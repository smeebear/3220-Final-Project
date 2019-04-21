library(tidyverse)
library(xgboost)
library(magrittr)
library(C50)
set.seed(0)
 
#---------------------------
cat("Loading data...\n")

bbalance <- read_csv("input/bureau_balance.csv") 
bureau <- read_csv("input/bureau.csv")
cc_balance <- read_csv("input/credit_card_balance.csv")
payments <- read_csv("input/installments_payments.csv") 
pc_balance <- read_csv("input/POS_CASH_balance.csv")
prev <- read_csv("input/previous_application.csv")
tr <- read_csv("input/application_train.csv") 
te <- read_csv("input/application_test.csv")

#---------------------------
cat("Preprocessing...\n")

fn <- funs(mean, sd, min, max, sum, n_distinct, .args = list(na.rm = TRUE))

sum_bbalance <- bbalance %>%
  mutate_if(is.character, funs(factor(.) %>% as.integer)) %>% 
  group_by(SK_ID_BUREAU) %>% 
  summarise_all(fn) 
rm(bbalance); gc()

sum_bureau <- bureau %>% 
  left_join(sum_bbalance, by = "SK_ID_BUREAU") %>% 
  select(-SK_ID_BUREAU) %>% 
  mutate_if(is.character, funs(factor(.) %>% as.integer)) %>% 
  group_by(SK_ID_CURR) %>% 
  summarise_all(fn)
rm(bureau, sum_bbalance); gc()

sum_cc_balance <- cc_balance %>% 
  select(-SK_ID_PREV) %>% 
  mutate_if(is.character, funs(factor(.) %>% as.integer)) %>% 
  group_by(SK_ID_CURR) %>% 
  summarise_all(fn)
rm(cc_balance); gc()

sum_payments <- payments %>% 
  select(-SK_ID_PREV) %>% 
  mutate(PAYMENT_PERC = AMT_PAYMENT / AMT_INSTALMENT,
         PAYMENT_DIFF = AMT_INSTALMENT - AMT_PAYMENT,
         DPD = DAYS_ENTRY_PAYMENT - DAYS_INSTALMENT,
         DBD = DAYS_INSTALMENT - DAYS_ENTRY_PAYMENT,
         DPD = ifelse(DPD > 0, DPD, 0),
         DBD = ifelse(DBD > 0, DBD, 0)) %>% 
  group_by(SK_ID_CURR) %>% 
  summarise_all(fn) 
rm(payments); gc()

sum_pc_balance <- pc_balance %>% 
  select(-SK_ID_PREV) %>% 
  mutate_if(is.character, funs(factor(.) %>% as.integer)) %>% 
  group_by(SK_ID_CURR) %>% 
  summarise_all(fn)
rm(pc_balance); gc()

sum_prev <- prev %>%
  select(-SK_ID_PREV) %>% 
  mutate_if(is.character, funs(factor(.) %>% as.integer)) %>% 
  mutate(DAYS_FIRST_DRAWING = ifelse(DAYS_FIRST_DRAWING == 365243, NA, DAYS_FIRST_DRAWING),
         DAYS_FIRST_DUE = ifelse(DAYS_FIRST_DUE == 365243, NA, DAYS_FIRST_DUE),
         DAYS_LAST_DUE_1ST_VERSION = ifelse(DAYS_LAST_DUE_1ST_VERSION == 365243, NA, DAYS_LAST_DUE_1ST_VERSION),
         DAYS_LAST_DUE = ifelse(DAYS_LAST_DUE == 365243, NA, DAYS_LAST_DUE),
         DAYS_TERMINATION = ifelse(DAYS_TERMINATION == 365243, NA, DAYS_TERMINATION),
         APP_CREDIT_PERC = AMT_APPLICATION / AMT_CREDIT) %>% 
  group_by(SK_ID_CURR) %>% 
  summarise_all(fn) 
rm(prev); gc()

tri <- 1:nrow(tr)
y <- tr$TARGET

tr_te <- tr %>% 
  select(-TARGET) %>% 
  bind_rows(te) %>%
  left_join(sum_bureau, by = "SK_ID_CURR") %>% 
  left_join(sum_cc_balance, by = "SK_ID_CURR") %>% 
  left_join(sum_payments, by = "SK_ID_CURR") %>% 
  left_join(sum_pc_balance, by = "SK_ID_CURR") %>% 
  left_join(sum_prev, by = "SK_ID_CURR") %>% 
  select(-SK_ID_CURR) %>% 
  mutate_if(is.character, funs(factor(.) %>% as.integer)) %>% 
  mutate(na = apply(., 1, function(x) sum(is.na(x))),
         DAYS_EMPLOYED = ifelse(DAYS_EMPLOYED == 365243, NA, DAYS_EMPLOYED),
         DAYS_EMPLOYED_PERC = sqrt(DAYS_EMPLOYED / DAYS_BIRTH),
         INCOME_CREDIT_PERC = AMT_INCOME_TOTAL / AMT_CREDIT,
         INCOME_PER_PERSON = log1p(AMT_INCOME_TOTAL / CNT_FAM_MEMBERS),
         ANNUITY_INCOME_PERC = sqrt(AMT_ANNUITY / (1 + AMT_INCOME_TOTAL)),
         LOAN_INCOME_RATIO = AMT_CREDIT / AMT_INCOME_TOTAL,
         ANNUITY_LENGTH = AMT_CREDIT / AMT_ANNUITY,
         CHILDREN_RATIO = CNT_CHILDREN / CNT_FAM_MEMBERS, 
         CREDIT_TO_GOODS_RATIO = AMT_CREDIT / AMT_GOODS_PRICE,
         INC_PER_CHLD = AMT_INCOME_TOTAL / (1 + CNT_CHILDREN),
         SOURCES_PROD = EXT_SOURCE_1 * EXT_SOURCE_2 * EXT_SOURCE_3,
         CAR_TO_BIRTH_RATIO = OWN_CAR_AGE / DAYS_BIRTH,
         CAR_TO_EMPLOY_RATIO = OWN_CAR_AGE / DAYS_EMPLOYED,
         PHONE_TO_BIRTH_RATIO = DAYS_LAST_PHONE_CHANGE / DAYS_BIRTH,
         PHONE_TO_EMPLOY_RATIO = DAYS_LAST_PHONE_CHANGE / DAYS_EMPLOYED) 

docs <- str_subset(names(tr), "FLAG_DOC")
live <- str_subset(names(tr), "(?!NFLAG_)(?!FLAG_DOC)(?!_FLAG_)FLAG_")
inc_by_org <- tr_te %>% 
  group_by(ORGANIZATION_TYPE) %>% 
  summarise(m = median(AMT_INCOME_TOTAL)) %$% 
  setNames(as.list(m), ORGANIZATION_TYPE)

rm(tr, te, fn, sum_bureau, sum_cc_balance, 
   sum_payments, sum_pc_balance, sum_prev); gc()

tr_te %<>% 
  mutate(DOC_IND_KURT = apply(tr_te[, docs], 1, moments::kurtosis),
         LIVE_IND_SUM = apply(tr_te[, live], 1, sum),
         NEW_INC_BY_ORG = recode(tr_te$ORGANIZATION_TYPE, !!!inc_by_org),
         NEW_EXT_SOURCES_MEAN = apply(tr_te[, c("EXT_SOURCE_1", "EXT_SOURCE_2", "EXT_SOURCE_3")], 1, mean),
         NEW_SCORES_STD = apply(tr_te[, c("EXT_SOURCE_1", "EXT_SOURCE_2", "EXT_SOURCE_3")], 1, sd))%>%
  mutate_all(funs(ifelse(is.nan(.), NA, .))) %>% 
  mutate_all(funs(ifelse(is.infinite(.), NA, .))) %>% 
  data.matrix()

#---------------------------
cat("Preparing data...\n")
dtest <- xgb.DMatrix(data = tr_te[-tri, ])
tr_te <- tr_te[tri, ]
tri <- caret::createDataPartition(y, p = 0.9, list = F) %>% c()
dtrain <- xgb.DMatrix(data = tr_te[tri, ], label = y[tri])
dval <- xgb.DMatrix(data = tr_te[-tri, ], label = y[-tri])
cols <- colnames(tr_te)

# rm(tr_te, y, tri); gc()

# My code

# Convert tr_te to train and test data frames
tri <- 1:length(y)
train_data_df <- as.data.frame(tr_te[tri,])
test_data_df <- as.data.frame(tr_te[-tri,])

# Define a cost matrix penalizing incorrect classification of bad (those who are likely to default on loans)
cost_mat <- matrix(c(0, 10, 1, 0), nrow = 2)
rownames(cost_mat) <- colnames(cost_mat) <- c("bad", "good")

# Convert 0 to good and 1 to bad
y_good_bad <- as.factor(ifelse(y == 0, 'good', 'bad'))


nData <- nrow(train_data_df)
trainIndex = sample(1:nData, size = round(0.8*nData), replace=FALSE)
train = train_data_df[trainIndex ,]
validation = train_data_df[-trainIndex, ]
y_good_bad_train = y_good_bad[trainIndex]
y_good_bad_validation = y_good_bad[-trainIndex]

rm(tr_te, train_data_df, dtrain, dtest, dval)

# C5.0Control settings. Most are default. Default is specified in a comment otherwise
control <- C5.0Control(
  subset = TRUE,
  bands = 0,
  winnow = TRUE, # Default = FALSE
  noGlobalPruning = FALSE,
  CF = 0.25,
  minCases = 100, # Default = 2
  fuzzyThreshold = FALSE,
  sample = 0,
  seed = sample.int(4096, size = 1) - 1L,
  earlyStopping = TRUE,
  label = 'outcome'
)

# Train data
model <- C5.0(train, y_good_bad_train, control = control, costs = cost_mat)


# estimate the performance using randomly partitioned data
predicted.labels = predict(model, validation)
num.incorrect.labels = sum(predicted.labels != y_good_bad_validation)
misclassification.rate = num.incorrect.labels / nrow(validation)
# evaluate and return accuracy
num.correct.labels = sum(predicted.labels == y_good_bad_validation)
accuracy = num.correct.labels / nrow(validation)
print(sprintf("misclassification.rate: %f, accuracy: %f", misclassification.rate, accuracy))


# Evaluate on test data and write results
predicted.test <- predict(model, test_data_df)
read_csv("input/sample_submission.csv") %>%  
  mutate(SK_ID_CURR = as.integer(SK_ID_CURR),
         TARGET = ifelse(predicted.test == 'good', 0, 1)) %>%
  write_csv(paste0("tidy_xgb_C5_0_", round(accuracy, 5), ".csv"))

# End my code

#---------------------------
#cat("Training model...\n")
#p <- list(objective = "binary:logistic",
#          booster = "gbtree",
#          eval_metric = "auc",
#          nthread = 4,
#          eta = 0.05,
#          max_depth = 6,
#          min_child_weight = 30,
#          gamma = 0,
#          subsample = 0.85,
#          colsample_bytree = 0.7,
#          colsample_bylevel = 0.632,
#          alpha = 0,
#          lambda = 0,
#          nrounds = 2000)
#
#set.seed(0)
#m_xgb <- xgb.train(p, dtrain, p$nrounds, list(val = dval), print_every_n = 50, early_stopping_rounds = 300)
#
#xgb.importance(cols, model=m_xgb) %>% 
#  xgb.plot.importance(top_n = 30)
#
#---------------------------
#read_csv("input/sample_submission.csv") %>%  
#  mutate(SK_ID_CURR = as.integer(SK_ID_CURR),
#         TARGET = predict(m_xgb, dtest)) %>%
#  write_csv(paste0("tidy_xgb_", round(m_xgb$best_score, 5), ".csv"))
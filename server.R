library(class)
library(dplyr)
library(C50)
library(printr)

# read in the data # reassign depth values under 10 to zero
#df$depth[df$depth<10] <- 0
votes <- read.csv("C:/CSC_3220/house-votes-84-numeric.csv", header=TRUE)
votes
# separate into training and non-training
n = nrow(votes)
trainIndex = sample(1:n, size = round(0.6*n), replace=FALSE)
train = votes[trainIndex ,]
notTrain = votes[-trainIndex ,]
# separate the non-training into validation and test
n = nrow(notTrain)
validationIndex = sample(1:n, size = round(0.5*n), replace=FALSE)
validation = notTrain[validationIndex,]
test = notTrain[-validationIndex,]


server <- function(input, output) {
  output$distPlot <- renderPlot({
    
    if(input$model == "C 5.0"){
      model <- C5.0(party ~., data=train)
      plot(model)
    }
    
})}
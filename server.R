library(class)
library(dplyr)
library(class)
library(C50)
library(printr)

# read in the data
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
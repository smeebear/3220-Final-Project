library(class)
library(dplyr)
library(C50)
library(printr)
library(shiny)


server <- function(input, output) {
  output$distPlot <- renderPlot({
    
      model <- C5.0(party ~., data=train)
      plot(model)
    
  })
  observeEvent(input$eval, {
    
    # put in the stuff to check input against model 
    
  })
  
  
  }
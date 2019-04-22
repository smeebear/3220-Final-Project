library(class)
library(dplyr)
library(C50)
library(printr)



server <- function(input, output) {
  output$distPlot <- renderPlot({
    
    if(input$model == "C 5.0"){
      model <- C5.0(party ~., data=train)
      plot(model)
    }
    
  })
  observeEvent(input$eval, {
    
    # put in the stuff to check input against model 
    
  })
  
  
  }
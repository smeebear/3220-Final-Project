library(class)
library(dplyr)
library(C50)
library(printr)
library(shiny)

credit = TRUE
err = 0

server <- function(input, output) {
  output$distPlot <- renderPlot({
    
      model <- C5.0(party ~., data=train)
      plot(model)
    
  })
  observeEvent(input$eval, {
    
    # put in the stuff to check input against model 
    if(input$education <= 2)
    {
      if(input$ctg_ratio <= 1.145)
      {
        credit = TRUE
      }
      else
      {
        if(input$annuity_length > 21.45468)
        {
          credit = TRUE
        }
        else
        {
          if(input$days_birth <= -12851)
          {
            credit = TRUE
          }
          else
          {
            credit = FALSE
          }
        }
      }
    }
    else
    {
      if(input$days_birth <= -14788)
      {
        if(input$annuity_length <= 10.77844)
        {
          credit = TRUE
        }
        else
        {
          if(input$annuity_length <= 12.6609)
          {
            credit = FALSE
          }
          else
          {
            if(input$name_prod_type_min <= 1)
            {
              if(input$days_credit_mean > -854.5555)
              {
                credit = FALSE
              }
              else
              {
                if(input$name_contract_status_mean <= 1.814815)
                {
                  credit = TRUE
                }
                else credit = FALSE
              }
            }
            else
            {
              if(input$ctg_ratio <= 1.1584)
              {
                credit = TRUE
              }
              else
              {
                if(input$code_gender <= 1)
                {
                  credit = TRUE
                }
                else credit = FALSE
              }
            }
          }
        }
      }
      else
      {
        if(input$ctg_ratio > 1.211197)
        {
          credit = FALSE
        }
      }
    }
    
  })
  
  
  }
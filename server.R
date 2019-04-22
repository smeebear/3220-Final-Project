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
  
  output$credit = FALSE
  
  observeEvent(input$eval, {
    
    # put in the stuff to check input against model 
    if(input$education <= 2)
    {
      if(input$ctg_ratio <= 1.145)
      {
        output$credit = TRUE
      }
      else
      {
        if(input$annuity_length > 21.45468)
        {
          output$credit = TRUE
        }
        else
        {
          if(input$days_birth <= -12851)
          {
            output$credit = TRUE
          }
          else
          {
            output$credit = FALSE
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
          output$credit = TRUE
        }
        else
        {
          if(input$annuity_length <= 12.6609)
          {
            output$credit = FALSE
          }
          else
          {
            if(input$name_prod_type_min <= 1)
            {
              if(input$days_credit_mean > -854.5555)
              {
                output$credit = FALSE
              }
              else
              {
                if(input$name_contract_status_mean <= 1.814815)
                {
                  output$credit = TRUE
                }
                else output$credit = FALSE
              }
            }
            else
            {
              if(input$ctg_ratio <= 1.1584)
              {
                output$credit = TRUE
              }
              else
              {
                if(input$code_gender <= 1)
                {
                  output$credit = TRUE
                }
                else output$credit = FALSE
              }
            }
          }
        }
      }
      else
      {
        if(input$ctg_ratio > 1.211197)
        {
          output$credit = FALSE
        }
        else
        {
          if(input$days_employed <= -1785)
          {
            if(input$name_contract_status_mean <= 1.636364) output$credit = TRUE
            else output$credit = FALSE
          }
          else
          {
            if(input$payment_perc_mean <= 0.9294118) output$credit = FALSE
            else
            {
              if(input$name_contract_status_mean > 1.78125) output$credit = FALSE
              else
              {
                if(input$days_credit_mean <= -914.0714) output$credit = TRUE
                else output$credit = FALSE
              }
            }
          }
        }
      }
    }
    
  })
  
  
  }
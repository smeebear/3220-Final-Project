library(class)
library(dplyr)
library(C50)
library(printr)
library(shiny)

credit = "good"
err = 0

server <- function(input, output) {
  
  output$text = renderPrint({credit})
  
  #output$credit = "bad"
  
  observeEvent(input$eval, {
    
    # put in the stuff to check input against model 
    if(input$education <= 2)
    {
      if(input$ctg_ratio <= 1.145)
      {
        credit = "good"
      }
      else
      {
        if(as.double(input$annuity_length) > 21.45468)
        {
          credit = "good"
        }
        else
        {
          if(input$days_birth <= -12851)
          {
            credit = "good"
          }
          else
          {
            credit = "bad"
          }
        }
      }
    }
    else
    {
      if(input$days_birth <= -14788)
      {
        if(as.double(input$annuity_length) <= 10.77844)
        {
          credit = "good"
        }
        else
        {
          if(as.double(input$annuity_length) <= 12.6609)
          {
            credit = "bad"
          }
          else
          {
            if(input$name_prod_type_min <= 1)
            {
              if(input$days_credit_mean > -854.5555)
              {
                credit = "bad"
              }
              else
              {
                if(input$name_contract_status_mean <= 1.814815)
                {
                  credit = "good"
                }
                else credit = "bad"
              }
            }
            else
            {
              if(input$ctg_ratio <= 1.1584)
              {
                credit = "good"
              }
              else
              {
                if(input$code_gender <= 1)
                {
                  credit = "good"
                }
                else credit = "bad"
              }
            }
          }
        }
      }
      else
      {
        if(input$ctg_ratio > 1.211197)
        {
          credit = "bad"
        }
        else
        {
          if(input$days_employed <= -1785)
          {
            if(input$name_contract_status_mean <= 1.636364) credit = "good"
            else credit = "bad"
          }
          else
          {
            if(input$payment_perc_mean <= 0.9294118) credit = "bad"
            else
            {
              if(input$name_contract_status_mean > 1.78125) credit = "bad"
              else
              {
                if(input$days_credit_mean <= -914.0714) credit = "good"
                else credit = "bad"
              }
            }
          }
        }
      }
    }
    output$text = renderPrint({credit})

    output$credit_opinion <- renderImage({
      if (is.null(credit))
        return(NULL)
      
      if (credit == "good") {
        return(list(
          src = "thumbsup.jpg",
          contentType = "image/jpg",
          alt = "good"
        ))
      } else if (credit == "bad") {
        return(list(
          width = 300,
          height = 300,
          src = "thumbsdown.jpg",
          filetype = "image/jpg",
          alt = "bad"
        ))
      }
      
    }, deleteFile = FALSE)
    
  })
  
  
  }
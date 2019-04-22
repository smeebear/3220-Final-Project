library(shiny)

# Define UI for app ----
ui <- fluidPage(

  # App title ----
  titlePanel("Home Credit Default"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(
    
      # Input: Slider for the number of bins ----
      selectInput("education", label = "Education Type",
                  choices = list("Higher Education" = 4, "Secondary/ Secondary sepcial" =3, "Incomplete Higher"=1, "lower secondary"=2, "Academic Degree"=5)),
      selectInput("ctg_ratio", label = "CREDIT_TO_GOODS_RATIO = AMT_CREDIT / AMT_GOODS_PRICE",
                  choices = list("ratio <= 1.452"= 1.452, "ratio > 1.452" = 2)),
      selectInput("days_birth", label = "Age",
                  choices = list("Younger than 40" = -14782, "Older than 40" = -14800)),
      textInput("annuity_length", "ANNUITY_LENGTH = AMT_CREDIT / AMT_ANNUITY", value="12.34"),
      selectInput("name_prod_type_min", label = "Name of Product Type",
                  choices = list("x-sell"=1, "walk-in"=2)),
      selectInput("name_contract_status_mean", label = "status of previous application",
                  choices = list("Approved" = 1.1, "Refused" =1.72 , "Canceled" =1.42,"Unused Offer" = 1.33)),
      selectInput("days_employed", label = "Employment Length",
                  choices = list("Less than 5 years" = -1784, "Greater than 5 years" = -1785)),
      selectInput("days_credit_mean", label = "How long before current application did client apply for Credit Bureau credit",
                  choices = list("greater than 2.5 years" = -915, "less than 2.5 years" = -914)),
      selectInput("payment_perc_mean", label = "PAYMENT_PERC = AMT_PAYMENT / AMT_INSTALMENT",
                  choices = list("greater than 93%"= 0.93, "less than 93%"=0.92)),
      selectInput("code_gender", label = "Gender",
                  choices = list("F"=1, "M"=2)),
      actionButton("eval", "Evaluate")
     
    
    # Main panel for displaying outputs ----
    
      ),
    mainPanel (
      verbatimTextOutput("text"),
      imageOutput("credit_opinion")
    )
    
    )
  
    # Create a new row for the table.
  )


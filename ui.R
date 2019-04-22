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
                choices = list("Higher Education" = 2, "Secondary/ Secondary sepcial" =3, "Incomplete Higher"=5, "lower secondary"=4, "Academic Degree"=1)),
      textInput("ctg_ratio", label = "CREDIT_TO_GOODS_RATIO = AMT_CREDIT / AMT_GOODS_PRICE", value = "1.145"),
      textInput("days_birth", label = "Age", value = "45"),
      textInput("annuity_length", "ANNUITY_LENGTH = AMT_CREDIT / AMT_ANNUITY", value="12.34"),
      selectInput("name_prod_type_min", label = "Name of Product Type",
                  choices = list("x-sell"=1, "walk-in"=2)),
      selectInput("name_contract_status_mean", label = "status of previous application",
                  choices = list("Approved" = 1.1, "Refused" =1.72 , "Canceled" =1.42,"Unused Offer" = 1.33)),
      selectInput("days_employed", label = "Employment Length",
                  choices = list("greater than 5 years" = -1785, "less than 5 years" = -1750)),
      textInput("days_credit_mean", label = "How many days before current application did client apply for Credit Bureau credit", value = "854"),
      selectInput("payment_perc_mean", label = "PAYMENT_PERC = AMT_PAYMENT / AMT_INSTALMENT",
                  choices = list("greater than 93%"= 0.93, "less than 93%"=0.92)),
      selectInput("code_gender", label = "Gender",
                  choices = list("F"=1, "M"=2)),
      actionButton("eval", "Evaluate")
     
    
    # Main panel for displaying outputs ----
    
      ),
    mainPanel (
      verbatimTextOutput("text"),
      imageOutput("credit_opinion"),
      imageOutput("tree")
    )
    
    )
  
    # Create a new row for the table.
  )


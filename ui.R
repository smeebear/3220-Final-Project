library(shiny)

# Define UI for app ----
ui <- fluidPage(

  # App title ----
  titlePanel("home Credit Default"),

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
      numericInput("annuity_length", "ANNUITY_LENGTH = AMT_CREDIT / AMT_ANNUITY", 12, min = 1, max = 25),
      selectInput("name_prod_type_min", label = "Name of Product Type",
                  choices = list("1", "2")),
      selectInput("name_contract_status_mean", label = "Name Contract Status Mean",
                  choices = list("1", "2")),
      selectInput("days_employed", label = "Days Employed",
                  choices = list("1", "2")),
      selectInput("days_credit_mean", label = "Days Credit Mean",
                  choices = list("1", "2")),
      selectInput("payment_perc_mean", label = "Payement Percentge Mean",
                  choices = list("1", "2")),
      selectInput("code_gender", label = "Gender",
                  choices = list("1", "2")),
      actionButton("eval", "Evaluate")
     
    
    # Main panel for displaying outputs ----
    
      ),
    mainPanel (
      verbatimTextOutput("text")
    )
    
    )
  
    # Create a new row for the table.
  )


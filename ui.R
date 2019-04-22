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
                  choices = list("1", "2")),
      selectInput("ctg_ratio", label = "Credit to Goods Ratio",
                  choices = list("1", "2")),
      selectInput("days_birth", label = "Days Birth",
                  choices = list("1", "2")),
      selectInput("annuity_length", label = "Annuity Length",
                  choices = list("1", "2")),
      selectInput("name_prod_type_min", label = "Name Product Type Min",
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
      plotOutput(outputId = "distPlot")
    )
    
    )
  
    # Create a new row for the table.
  )


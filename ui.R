library(shiny)

# Define UI for app ----
ui <- fluidPage(

  # App title ----
  titlePanel("Congressional Voting Records by Bill"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(
    
      # Input: Slider for the number of bins ----
      selectInput("bill", label = h3("Bill:"), 
                  choices = list("Bill 1" = "b1", "Bill 2" = "b2", "Bill 3" = "b3", "Bill 4" = "b4", 
                                 "Bill 5" = "b5", "Bill 6" = "b6", "Bill 7" = "b7", "Bill 8" = "b8", 
                                 "Bill 9" = "b9", "Bill 10" = "b10",  "Bill 11" = "b11",  "Bill 12" = "b12", 
                                 "Bill 13" = "b13", "Bill 14" = "b14", "Bill 15" = "b15", "Bill 16" = "b16"), 
                  selected = "b1"),
      selectInput("party", label = h3("Party:"),
                  choices = list("Both" = "both", "Democrat" = "democ", "Republican" = "repub"),
                  selected = "both")

    # Main panel for displaying outputs ----
    
      ),
    DT::dataTableOutput("table")
    )
    # Create a new row for the table.
  )


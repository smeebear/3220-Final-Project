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
    
      selectInput("model", label = "Model Type",
                  choices = list("Logistic Regression", "C 5.0"),
                  selected = "C 5.0")

    # Main panel for displaying outputs ----
    
      ),
    plotOutput(outputId = "distPlot")
    
    )
    # Create a new row for the table.
  )


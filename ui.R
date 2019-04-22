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
      selectInput("in1", label = "input",
                  choices = list("1", "2")),
      selectInput("in2", label = "input",
                  choices = list("1", "2")),
      selectInput("in3", label = "input",
                  choices = list("1", "2")),
      selectInput("in4", label = "input",
                  choices = list("1", "2")),
      selectInput("in5", label = "input",
                  choices = list("1", "2")),
      selectInput("in6", label = "input",
                  choices = list("1", "2")),
      selectInput("in7", label = "input",
                  choices = list("1", "2")),
      selectInput("in8", label = "input",
                  choices = list("1", "2")),
      selectInput("in9", label = "input",
                  choices = list("1", "2")),
      selectInput("in10", label = "input",
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


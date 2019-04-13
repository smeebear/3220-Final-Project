library(class)
library(dplyr)

votesInit <- read.csv("house-votes-84-numeric.csv", header=TRUE)

votesTable = data.frame(VotesFor = 0, Abstained = 0, VotesAgainst = 0)

server <- function(input, output) {
  output$table = DT::renderDataTable(DT::datatable({
    votes = votesInit
    if (input$party == "repub")
    {
      votes = votesInit %>% filter(party == "republican")
    }
    else if (input$party == "democ")
    {
      votes = votesInit %>% filter(party == "democrat")
    }
    
    
    if (input$bill == "b1")
    {
      votesTable$VotesFor = sum(votes$b1 == 1)
      votesTable$Abstained = sum(votes$b1 == 0)
      votesTable$VotesAgainst = sum(votes$b1 == -1)
    }
    else if (input$bill == "b2")
    {
      votesTable$VotesFor = sum(votes$b2 == 1)
      votesTable$Abstained = sum(votes$b2 == 0)
      votesTable$VotesAgainst = sum(votes$b2 == -1)
    }
    else if (input$bill == "b3")
    {
      votesTable$VotesFor = sum(votes$b3== 1)
      votesTable$Abstained = sum(votes$b3 == 0)
      votesTable$VotesAgainst = sum(votes$b3 == -1)
    }
    else if (input$bill == "b4")
    {
      votesTable$VotesFor = sum(votes$b4 == 1)
      votesTable$Abstained = sum(votes$b4 == 0)
      votesTable$VotesAgainst = sum(votes$b4 == -1)
    }
    else if (input$bill == "b5")
    {
      votesTable$VotesFor = sum(votes$b5 == 1)
      votesTable$Abstained = sum(votes$b5 == 0)
      votesTable$VotesAgainst = sum(votes$b5 == -1)
    }
    else if (input$bill == "b6")
    {
      votesTable$VotesFor = sum(votes$b6 == 1)
      votesTable$Abstained = sum(votes$b6 == 0)
      votesTable$VotesAgainst = sum(votes$b6 == -1)
    }
    else if (input$bill == "b7")
    {
      votesTable$VotesFor = sum(votes$b7 == 1)
      votesTable$Abstained = sum(votes$b7 == 0)
      votesTable$VotesAgainst = sum(votes$b7 == -1)
    }
    else if (input$bill == "b8")
    {
      votesTable$VotesFor = sum(votes$b8 == 1)
      votesTable$Abstained = sum(votes$b8 == 0)
      votesTable$VotesAgainst = sum(votes$b8 == -1)
    }
    else if (input$bill == "b9")
    {
      votesTable$VotesFor = sum(votes$b9 == 1)
      votesTable$Abstained = sum(votes$b9 == 0)
      votesTable$VotesAgainst = sum(votes$b9 == -1)
    }
    else if (input$bill == "b10")
    {
      votesTable$VotesFor = sum(votes$b10 == 1)
      votesTable$Abstained = sum(votes$b10 == 0)
      votesTable$VotesAgainst = sum(votes$b10 == -1)
    }
    else if (input$bill == "b11")
    {
      votesTable$VotesFor = sum(votes$b11 == 1)
      votesTable$Abstained = sum(votes$b11 == 0)
      votesTable$VotesAgainst = sum(votes$b11 == -1)
    }
    else if (input$bill == "b12")
    {
      votesTable$VotesFor = sum(votes$b12 == 1)
      votesTable$Abstained = sum(votes$b12 == 0)
      votesTable$VotesAgainst = sum(votes$b12 == -1)
    }
    else if (input$bill == "b13")
    {
      votesTable$VotesFor = sum(votes$b13 == 1)
      votesTable$Abstained = sum(votes$b13 == 0)
      votesTable$VotesAgainst = sum(votes$b13 == -1)
    }
    else if (input$bill == "b14")
    {
      votesTable$VotesFor = sum(votes$b14 == 1)
      votesTable$Abstained = sum(votes$b14 == 0)
      votesTable$VotesAgainst = sum(votes$b14 == -1)
    }
    else if (input$bill == "b15")
    {
      votesTable$VotesFor = sum(votes$b15 == 1)
      votesTable$Abstained = sum(votes$b15 == 0)
      votesTable$VotesAgainst = sum(votes$b15 == -1)
    }
    else if (input$bill == "b16")
    {
      votesTable$VotesFor = sum(votes$b16 == 1)
      votesTable$Abstained = sum(votes$b16 == 0)
      votesTable$VotesAgainst = sum(votes$b16 == -1)
    }
    
    
    votesTable
  }))
  

}
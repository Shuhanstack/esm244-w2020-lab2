# Attach packages

#

library(tidyverse)
library(shiny)
library(shinythemes)
library(here)


## read in spooky data

spooky <- read_csv(here("data", "spooky_data.csv"))


## create UI

ui <- fluidPage(
  theme = shinytheme("superhero"),
  titlePanel("Here is my awesome title"),
  sidebarLayout(
    sidebarPanel("My widgets are here",
                 selectInput(inputId = "state_select", # inputId can be named as anything the widges will be called
                             label = "Choose a state:",
                             choices = unique(spooky$state) # can type them in c("Cool California" = "California" will display Cool California and recognize that as California)
                             )
                 ),
    mainPanel("My outputs are here!",
              tableOutput(outputId = "candy_table")
              )
  )
)


server <- function(input, output){

  state_candy <- reactive({
    spooky %>%
      filter(state == input$state_select) %>%
      select(candy, pounds_candy_sold)
  }) # notation for reactive dataframe: ({ })

  output$candy_table <- renderTable({
    state_candy()
  })

}



shinyApp(ui = ui, server = server)

devtools::install_github("hankolofs/api_fetch")
library(apiFetch)
library(sp)
library(shiny)
library(ggplot2)
library(dplyr)



# Define UI for thenmap_viz application
ui <- fluidPage(
  # App Title
  titlePanel("The thenmap_viz App"),
  
  # Sidebar layout 
  sidebarLayout(
    
    # Sidebar panel 
    sidebarPanel(
      h1("Visualize historical and current borders"),
      h4(code("Select a date to create a map!")),
      
      # Input: date
      fluidRow(column(4, dateInput(inputId = "date",
                                   h3("Date"),
                                   value = "2020-01-01"))
      ),
    ),
    
    # Main panel for displaying a map
    mainPanel(
      # Output: Map
      plotOutput(outputId = "distPlot"),
      textOutput(outputId = "selected_var")
      
    )
  )    
  
)

# Define server 
server <- function(input, output) {
  # National borders of Thenmap data
  output$distPlot <- renderPlot({
    map_data_year <- fetch(date_str = input$date)$data
    map_bg <- fetch(date_str = "2020-01-01")$data
    ggplot() + 
      geom_sf(data = map_bg, fill = "grey", color = "grey") +
      geom_sf(data = map_data_year, fill = "#638f54", color = "white")

  })
  output$selected_var <- renderText(
    paste0("The green area corresponds to the national borders on ", input$date, ".")
  )
}

# Run the app ----
shinyApp(ui = ui, server = server)

#use in console
#runApp("thenmap_viz")


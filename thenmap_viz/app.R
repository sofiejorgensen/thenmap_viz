# install.packages("httr")
library(httr)

# install.packages("jsonlite")
library(jsonlite)

#install.packages("geojsonR")
library(geojsonR)

# install.packages("RCurl")
library(RCurl)

library(sp)

library(shiny)

# Extra plot
library(ggplot2)
library(dplyr)
require(maps)
require(viridis)

theme_set(
  theme_void()
)


# Define UI for application
ui <- fluidPage(
  # App Title
  titlePanel("The thenmap_vize App"),
  titlePanel("Hello Shiny Shiny World!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      h1("First level title"),
      h4(code("This is going to be amazing!")),
      br(), # New line
      h6("a paragraph of text."),
      p("p creates a paragraph of text."),
      # Widgets
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "year",
                  label = "Select year:",
                  min = 1900,
                  max = 2020,
                  value = 30),
      
      fluidRow(column(3, selectInput("select", h3("Country"), 
                                     choices = list("All countries" = 1, "Sweden" = 2,
                                                    "Hello land" = 3), selected = 1)),
               column(3, dateInput(inputId = "date",
                                   h3("Date"),
                                   value = "2000-01-01"),)
      ),
      
      
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Map ----
      plotOutput(outputId = "distPlot")
      
    )
  )    
  
)

# Define server logic ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    # Standard plot
    url <- paste0("http://api.thenmap.net/v2/world-2/geo/", input$date)
    download.file(url = url, "test.geojson", replace = TRUE)
    
    map_data <- geojson_read("test.geojson", what = "sp")
    plot(map_data, col="light blue")

  })
}

# Run the app ----
shinyApp(ui = ui, server = server)

#use in console
#runApp("thenmap_viz")

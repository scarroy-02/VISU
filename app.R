# Install required packages if not already installed
# install.packages("shiny")
# install.packages("ggplot2")

library(shiny)
library(shinydashboard)
library(ggplot2)

# Define UI
ui <- fluidPage(
  dashboardPage(
    dashboardHeader(title = "Plot Selector"),
    dashboardSidebar(
      selectInput("plot_selector", "Select a plot:",
                  choices = c("Plot 1", "Plot 2", "Plot 3", "Plot 4", "Plot 5"))
    ),
    dashboardBody(
      uiOutput("selected_plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Function to generate plots based on user selection
  output$selected_plot <- renderUI({
    plot_output <- switch(input$plot_selector,
                          "Plot 1" = plotOutput("plot1"),
                          "Plot 2" = plotOutput("plot2"),
                          "Plot 3" = plotOutput("plot3"),
                          "Plot 4" = plotOutput("plot4"),
                          "Plot 5" = plotOutput("plot5"))
    plot_output
  })
  
  # Generate Plot 1
  output$plot1 <- renderPlot({
    ggplot(data = iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
      geom_point() +
      labs(title = "Plot 1: Sepal Length vs Sepal Width")
  })
  
  # Generate Plot 2
  output$plot2 <- renderPlot({
    ggplot(data = mpg, aes(x = displ, y = hwy, color = factor(cyl))) +
      geom_point() +
      labs(title = "Plot 2: Displacement vs Highway MPG")
  })
  
  # Generate Plot 3
  output$plot3 <- renderPlot({
    ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) +
      geom_point(alpha = 0.6) +
      labs(title = "Plot 3: Carat vs Price")
  })
  
  # Generate Plot 4
  output$plot4 <- renderPlot({
    ggplot(data = mtcars, aes(x = wt, y = mpg)) +
      geom_point() +
      labs(title = "Plot 4: Car Weight vs MPG")
  })
  
  # Generate Plot 5
  output$plot5 <- renderPlot({
    ggplot(data = faithful, aes(x = eruptions, y = waiting)) +
      geom_point() +
      labs(title = "Plot 5: Old Faithful Eruptions")
  })
}

# Run the application
shinyApp(ui = ui, server = server)

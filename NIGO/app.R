
# Load required libraries
library(shiny)

# Define constants for cycle time and work effort for each step
cycle_time <- c(2, 3, 4, 2) # Example cycle times for each step
work_effort <- c(5, 7, 8, 6) # Example work efforts for each step

# Define UI
ui <- fluidPage(
  titlePanel("NIGO Impact Simulation"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("nigo_rate", "NIGO Rate (%)", min = 0, max = 100, value = 10)
    ),
    mainPanel(
      plotOutput("cycle_time_plot"),
      plotOutput("work_effort_plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Define a reactive expression for the simulation results
  simulation_results <- reactive({
    # Simulate process with NIGO instances based on the current slider value
    nigo_rate <- input$nigo_rate
    nigo_count <- round(nigo_rate / 100 * 4)
    nigo_steps <- sample(1:4, nigo_count, replace = TRUE)
    total_cycle_time <- sum(cycle_time) + nigo_count
    total_work_effort <- sum(work_effort) + nigo_count

    # Return simulation results as a reactive object
    return(list(
      cycle_time = total_cycle_time,
      work_effort = total_work_effort
    ))
  })

  # Generate cycle time plot
  output$cycle_time_plot <- renderPlot({
    # Plot cycle time with reactive simulation results
    barplot(cycle_time, main = "Cycle Time with NIGO Impact",
            xlab = "Step", ylab = "Cycle Time", names.arg = paste("Step", 1:4))
    abline(h = simulation_results()$cycle_time, col = "red", lwd = 2)
    legend("topright", legend = c("Cycle Time", "Total with NIGO"), col = c("black", "red"), lwd = 2)
  })

  # Generate work effort plot
  output$work_effort_plot <- renderPlot({
    # Plot work effort with reactive simulation results
    barplot(work_effort, main = "Work Effort with NIGO Impact",
            xlab = "Step", ylab = "Work Effort", names.arg = paste("Step", 1:4))
    abline(h = simulation_results()$work_effort, col = "red", lwd = 2)
    legend("topright", legend = c("Work Effort", "Total with NIGO"), col = c("black", "red"), lwd = 2)
  })
}

# Run the application
shinyApp(ui = ui, server = server)


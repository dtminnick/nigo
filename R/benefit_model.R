# Define parameters
baseline_cycle_time <- 10  # Baseline cycle time for non-NIGO cases (in days)
additional_time_per_NIGO <- 5  # Additional time per NIGO case (in days)
percentage_NIGO <- 20  # Percentage of NIGO cases
number_of_cases <- 1000  # Total number of cases

# Define parameters for work effort
number_of_steps_per_case <- 5  # Number of steps per case
average_time_per_step <- 1  # Average time per step (in hours)
additional_effort_per_NIGO <- 10  # Additional work effort per NIGO case (in hours)

# Define reduction levels for NIGO cases
reduction_levels <- c(0, 10, 20, 30, 40, 50)  # Reduction levels in percentage

# Initialize vectors to store results
cycle_time_benefits <- vector("numeric", length(reduction_levels))
work_effort_benefits <- vector("numeric", length(reduction_levels))
throughput_yields <- vector("numeric", length(reduction_levels))

# Iterate over reduction levels
for (i in seq_along(reduction_levels)) {
  reduction <- reduction_levels[i]

  # Calculate reduced percentage of NIGO cases
  reduced_percentage_NIGO <- percentage_NIGO * (1 - reduction / 100)

  # Calculate cycle time with reduced NIGO cases
  additional_time_NIGO <- (reduced_percentage_NIGO / 100) * additional_time_per_NIGO
  cycle_time_with_NIGO <- baseline_cycle_time + additional_time_NIGO

  # Calculate work effort with baseline and NIGO cases
  work_effort_baseline <- number_of_steps_per_case * average_time_per_step * number_of_cases
  additional_effort_NIGO <- (reduced_percentage_NIGO / 100) * additional_effort_per_NIGO * number_of_cases
  work_effort_with_NIGO <- work_effort_baseline + additional_effort_NIGO

  # Calculate throughput yield
  throughput_yield <- (100 - reduced_percentage_NIGO) / 100

  # Calculate total cycle time benefit
  total_cycle_time_benefit <- (baseline_cycle_time - cycle_time_with_NIGO) * number_of_cases

  # Calculate total work effort benefit
  total_work_effort_benefit <- work_effort_baseline - work_effort_with_NIGO

  # Store results
  cycle_time_benefits[i] <- total_cycle_time_benefit
  work_effort_benefits[i] <- total_work_effort_benefit
  throughput_yields[i] <- throughput_yield
}

# Output results
results <- data.frame(Reduction = reduction_levels,
                      Cycle_Time_Benefit = cycle_time_benefits,
                      Work_Effort_Benefit = work_effort_benefits,
                      Throughput_Yield = throughput_yields)
print(results)

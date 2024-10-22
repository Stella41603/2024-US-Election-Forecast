#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US elections dataset.
# Author: Xingjie Yao
# Date: 21 October 2024
# Contact: xingjie.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `US_presidential_election_forecast` rproj


#### Workspace setup ####
library(tidyverse)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("analysis_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}

#### Test data ####

# Check if the dataset has 500 rows
if (nrow(simulated_data) == 500) {
  message("Test Passed: The dataset has 500 rows.")
} else {
  stop("Test Failed: The dataset does not have 500 rows.")
}

# Check if the dataset has 5 columns 
if (ncol(simulated_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'state' or 'pollster' columns
if (all(simulated_data$state != "" & simulated_data$pollster != "")) {
  message("Test Passed: There are no empty strings in 'state' or 'pollster' columns.")
} else {
  stop("Test Failed: There are empty strings in 'state' or 'pollster' columns.")
}

# Check if the 'state' column has at least two unique values (to confirm variety)
if (n_distinct(simulated_data$state) >= 2) {
  message("Test Passed: The 'state' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'state' column contains less than two unique values.")
}

# Check if the 'pollster' column has at least two unique values (to confirm variety)
if (n_distinct(simulated_data$pollster) >= 2) {
  message("Test Passed: The 'pollster' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'pollster' column contains less than two unique values.")
}

# Check if pct values are between 0 and 1
if (all(simulated_data$pct >= 0 & simulated_data$pct <= 100)) {
  message("Test Passed: All pct values are between 0 and 100.")
} else {
  stop("Test Failed: Some pct values are outside the range 0 to 1.")
}


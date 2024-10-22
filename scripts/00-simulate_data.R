#### Preamble ####
# Purpose: Simulates a dataset for analyzing polling data, including key variables such as end date, pollster, state, and poll score, 
# to predict percentage support for Kamala Harris in the upcoming U.S. election.
# Author: Xingjie Yao
# Date: 21 October 2024
# Contact: xingjie.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` and `lubridate` packages must be installed
# Any other information needed? Make sure you are in the `US_presidential_election_forecast` rproj


#### Workspace setup ####
library(tidyverse)
library(lubridate)
set.seed(853)


#### Simulate data ####

# Load necessary libraries
library(dplyr)
library(lubridate)

# Define number of rows to simulate
n <- 500

# Pollster names 
pollsters <- c("Emerson", "YouGov", "Quinnipiac", "Marist", "SurveyUSA", 
               "Beacon/Shaw", "Ipsos", "Siena/NYT")

# State names 
states <- c("National", "Arizona", "California", "Georgia", "North Carolina", 
            "Washington", "Pennsylvania", "New Hampshire", "Texas", "Michigan", 
            "Nevada", "Wisconsin", "Montana", "Florida", "Ohio", "Massachusetts", 
            "Virginia", "Minnesota", "New York", "Nebraska", 
            "New Mexico", "Connecticut", "Rhode Island", "Maryland", 
            "Missouri", "Indiana", "Iowa")

simulated_data <- tibble(pct = rnorm(n, mean = 50, sd = 3)) %>% # Simulate percentage support for Harris) 
  mutate(
    pollscore = rnorm(n, mean = -1, sd = 0.15),  # Simulate pollscore
    pollster = sample(pollsters, n, replace = TRUE),  # Randomly assign pollster
    state = sample(states, n, replace = TRUE),  # Randomly assign states
    end_date = sample(seq(as.Date("2024-10-01"), as.Date("2024-10-16"), by = "day"), n, replace = TRUE)  # Simulate end dates
  )

# Display the first few rows of the simulated data
simulated_data %>% head()

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")

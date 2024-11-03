#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US elections dataset.
# Author: Xingjie Yao
# Date: 21 October 2024
# Contact: xingjie.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` and `testthat` packages must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `US_presidential_election_forecast` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Define test cases
test_that("Dataset is loaded successfully", {
  expect_true(exists("simulated_data"))
})

test_that("Dataset has 500 rows", {
  expect_equal(nrow(simulated_data), 500)
})

test_that("Dataset has 5 columns", {
  expect_equal(ncol(simulated_data), 5)
})

test_that("Dataset contains no missing values", {
  expect_true(all(!is.na(simulated_data)))
})

test_that("'state' and 'pollster' columns have no empty strings", {
  expect_true(all(simulated_data$state != "" & simulated_data$pollster != ""))
})

test_that("'state' column contains at least two unique values", {
  expect_gte(n_distinct(simulated_data$state), 2)
})

test_that("'pollster' column contains at least two unique values", {
  expect_gte(n_distinct(simulated_data$pollster), 2)
})

test_that("'pct' values are between 0 and 100", {
  expect_true(all(simulated_data$pct >= 0 & simulated_data$pct <= 100))
})

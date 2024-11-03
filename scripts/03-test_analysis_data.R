#### Preamble ####
# Purpose: Tests the integrity and validity of the cleaned polling dataset for Kamala Harris, 
# ensuring it meets specified criteria for analysis.
# Author: Xingjie Yao
# Date: 21 October 2024
# Contact: xingjie.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse`, `arrow`, `testthat` packages must be installed and loaded
  # - 02-clean_data.R must have been run
# Any other information needed? Confirm that the dataset exists in data/02-analysis_data/.


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(testthat)

just_harris_high_quality <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Define test cases
test_that("Dataset is loaded successfully", {
  expect_true(exists("just_harris_high_quality"))
})

test_that("Dataset has 464 rows", {
  expect_equal(nrow(just_harris_high_quality), 464)
})

test_that("Dataset has 5 columns", {
  expect_equal(ncol(just_harris_high_quality), 5)
})

test_that("Dataset contains no missing values", {
  expect_true(all(!is.na(just_harris_high_quality)))
})

test_that("'state' and 'pollster' columns have no empty strings", {
  expect_true(all(just_harris_high_quality$state != "" & just_harris_high_quality$pollster != ""))
})

test_that("'state' column contains at least two unique values", {
  expect_gte(n_distinct(just_harris_high_quality$state), 2)
})

test_that("'pollster' column contains at least two unique values", {
  expect_gte(n_distinct(just_harris_high_quality$pollster), 2)
})

test_that("'pct' values are between 0 and 100", {
  expect_true(all(just_harris_high_quality$pct >= 0 & just_harris_high_quality$pct <= 100))
})


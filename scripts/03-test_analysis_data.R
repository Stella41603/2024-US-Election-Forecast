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

just_harris_high_quality <- read_parquet("data/02-analysis_data/analysis_data.parquet")


#### Test data ####
# Check if the dataset has 464 rows
if (nrow(just_harris_high_quality) == 464) {
  message("Test Passed: The dataset has 464 rows.")
} else {
  stop("Test Failed: The dataset does not have 464 rows.")
}

# Check if the dataset has 5 columns 
if (ncol(just_harris_high_quality) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 5 columns.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(just_harris_high_quality))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'state' or 'pollster' columns
if (all(just_harris_high_quality$state != "" & just_harris_high_quality$pollster != "")) {
  message("Test Passed: There are no empty strings in 'state' or 'pollster' columns.")
} else {
  stop("Test Failed: There are empty strings in 'state' or 'pollster' columns.")
}

# Check if the 'state' column has at least two unique values (to confirm variety)
if (n_distinct(just_harris_high_quality$state) >= 2) {
  message("Test Passed: The 'state' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'state' column contains less than two unique values.")
}

# Check if the 'pollster' column has at least two unique values (to confirm variety)
if (n_distinct(just_harris_high_quality$pollster) >= 2) {
  message("Test Passed: The 'pollster' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'pollster' column contains less than two unique values.")
}

# Check if pct values are between 0 and 1
if (all(just_harris_high_quality$pct >= 0 & just_harris_high_quality$pct <= 100)) {
  message("Test Passed: All pct values are between 0 and 100.")
} else {
  stop("Test Failed: Some pct values are outside the range 0 to 1.")
}

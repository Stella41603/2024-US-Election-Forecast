#### Preamble ####
# Purpose: Models the percentage support for Harris based on polling data, 
# exploring relationships with key predictors such as end date, pollster, state, and poll score.
# Author: Xingjie Yao
# Date: 21 October 2024
# Contact: xingjie.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 03-test_data.R must have been run
# Any other information needed? Confirm that the dataset exists in data/02-analysis_data/.


#### Workspace setup ####
library(tidyverse)

#### Read data ####
just_harris_high_quality <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Starter models ####
# Model 1: pct as a function of end_date
model_date <- lm(pct ~ end_date, data = just_harris_high_quality)

# Model 2: pct as a function of end_date, pollster, state, and pollscore
model_date_pollster <- lm(pct ~ end_date + pollster + state + pollscore, data = just_harris_high_quality)

# Augment data with model predictions
just_harris_high_quality <- just_harris_high_quality |>
  mutate(
    fitted_date = predict(model_date),
    fitted_date_pollster = predict(model_date_pollster)
  )

# Plot model predictions
# Model 1
ggplot(just_harris_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date), color = "blue", linetype = "dotted") +
  theme_classic() +
  labs(y = "Harris percent", x = "Date", title = "Linear Model: pct ~ end_date")

# Model 2
ggplot(just_harris_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date_pollster), color = "blue", linetype = "dotted") +
  facet_wrap(vars(pollster)) +
  theme_classic() +
  labs(y = "Harris percent", x = "Date", title = "Linear Model: pct ~ end_date + pollster")

#### Save model ####
saveRDS(
  model_date,
  file = "models/model_date.rds"
)

saveRDS(
  model_date_pollster,
  file = "models/model_date_pollster.rds"
)




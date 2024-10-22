#### Preamble ####
# Purpose: Cleans the raw polling data recorded for Kamala Harris, 
#   focusing on high-quality polls to analyze voter support in the upcoming U.S. election.
# Author: Xingjie Yao
# Date: 21 October 2024
# Contact: xingjie.yao@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse`, `arrow`, `janitor` packages must be installed and loaded
  # - 00-simulate_data.R must have been run
  # - Make sure the polls dataset is downloaded from https://projects.fivethirtyeight.com/polls/president-general/2024/national/
# Any other information needed? Ensure you are working in the appropriate project directory, 
# and confirm that the required packages (tidyverse, arrow, janitor) are installed and loaded.

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)

#### Clean data ####
#### Prepare dataset ####
# Read in the data and clean variable names
data <- read_csv("data/01-raw_data/president_polls.csv") |>
  clean_names()

# Filter data to Harris estimates based on high-quality polls after she declared
just_harris_high_quality <- data |>
  filter(
    candidate_name == "Kamala Harris",
    numeric_grade >= 2.7 # Need to investigate this choice - come back and fix. 
    # Also need to look at whether the pollster has multiple polls or just one or two - filter out later
  ) |>
  mutate(
    state = if_else(is.na(state), "National", state), # Hacky fix for national polls - come back and check
    end_date = mdy(end_date)
  ) |>
  filter(end_date >= as.Date("2024-07-21")) |> # When Harris declared
    select(pct, pollster, state, end_date, pollscore) %>% na.omit()


#### Plot data ####
base_plot <- ggplot(just_harris_high_quality, aes(x = end_date, y = pct)) +
  theme_classic() +
  labs(y = "Harris percent", x = "Date")

# Plots poll estimates and overall smoothing
base_plot +
  geom_point() +
  geom_smooth()

# Color by pollster
# This gets messy - need to add a filter - see line 21
base_plot +
  geom_point(aes(color = pollster)) +
  geom_smooth() +
  theme(legend.position = "bottom")

# Facet by pollster
# Make the line 21 issue obvious
# Also - is there duplication???? Need to go back and check
base_plot +
  geom_point() +
  geom_smooth() +
  facet_wrap(vars(pollster))

# Color by pollscore
base_plot +
  geom_point(aes(color = factor(pollscore))) +
  geom_smooth() +
  theme(legend.position = "bottom")


#### Save data ####
write_parquet(x = just_harris_high_quality,
              sink = "data/02-analysis_data/analysis_data.parquet")





# This creates the study files for the "Limits to Growth" strategy analysis
# Created by: Peter Hovmand October 5, 2025

# Load and view the template
library(readr)
library(tidyverse)
template <- read_csv("Template.csv")

# Create the strategy_study1_df

# Find the variable names with switches for turning policies on
# and off where 1=on and 0=off. 
SW_vec <- grep("SW", names(template))
SW_vars <- names(template[SW_vec])

# Create a list of lists with switch variables and values. 
# Note that for this first strategy study all the defaul effect 
# sizes of 0.5 are used which means that the "total" effect size 
# of the strategy is the sum of all the active interventions
SW_list <- list(
  "IP1 Crude Birth Rate.SW" = c(0,1),
  "IP2 Mortality Rate.SW"= c(0,1),
  "IP3 Carrying Capacity.SW" = c(0,1),
  "IP4 Effect of Population Size on Births.SW" = c(0,1)
)

# For strategy_study1_df, create a data frame with all combinations and
# stacked effect sizes
strategy_study1_df<-expand.grid(SW_list)

# write the results to the Study1.csv
write_csv(strategy_study1_df,"strategy_study1.csv")

# Imports results from study 1 for plotting and analysis
# Created by: Oct 5, 2025 Peter S. Hovmand 
# Revised by: Nov 2, 2025 Peter S. Hovmand adapted to strategy study

# import results
library(readr)
library(tidyverse)
results <- read_csv("strategy_study1_results.csv")

# get the policy switch variables
vars <- names(results)
SW_vec <- grep("SW", vars)

# check time horizon
range(results$Years)
ftable(results[results$Years==100,SW_vec])

# create a vector to summarize the policy switches that are on
scenario <- apply(results[,vars[SW_vec]],1, paste0, collapse="-")

# select the final population for comparisons against policy 
# scenarios
results %>%
  mutate(Scenario = scenario) %>%
  filter(Years == 100) %>%
  mutate(`Final Population` = Population) %>%
  select(Scenario, `Final Population`) -> tmp

# sort the results from highest to lowest and show
# the top 10 scenarios
tmp %>%
  arrange(desc(`Final Population`)) %>% head(10) 

# construct a plot ordered plot of the the strategies by the final 
# value of the population
tmp %>%
  arrange(`Final Population`) %>%
  mutate(Scenario=factor(Scenario, levels = Scenario)) %>%
  ggplot() + 
    geom_col(aes(x=`Final Population`,y=Scenario))



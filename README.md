# Strategy Analysis

This set of exercises from [SD4DS](https://github.com/CBSDLab/SD4DS) provides an introduction to designing and running a strategy analysis where one is interested in testing combinations of policies. Since the number of combinations potential strategies grows exponentially with the number of policies being considered, the computation time grows exponentially, which makes running a strategy analysis on the High Performance Computing (HPC) cluster appealing.

The approach to conducting a strategy analysis builds on the approach from the [SD4DS-policy-analysis](https://github.com/CBSDLab/SD4DS-policy-analysis) using the "limits to growth v2.stmx" file with the policy switches added to the model.

## Overview

## 1. Testing strategies as combinations of policies

## 2. Diagnosing and fixing OUT_OF_Memory error

## 3. Analyzing and plotting results

Once we have the results file from our strategy study, we'll want to download and analyze the results. This is generally better done locally on a laptop or desktop as most laptops/desktops can process data of this size and it's highly interactive with refining code, choosing among many options for vizualization, and highly customized.

Start by downloading the .csv file from the strategy analysis to your local computer. Although this example uses R to illustrate some basic analyses, one could use any of popular programming language or software application for visualizing and analyzing results including Excel, Python, Tableau, SPSS, SAS, STATA, etc.

The first step is usually to get a sense of the best strategies on the outcome variable of interest. The following R code loads the libraries needed, imports the results, creates a name for each scenario based on the switch values, and arranges the results by descending order of the highest population at the end of the simulation with a list of the best 10 best strategies. Note that in this simple model, there are a total of 16 strategies, so the top 10 of 16 might not be all that interesting. However, it does take a lot of policy switches to get beyond this in scope (add one more and we are at 32 combinations, one more and 64 combinations, yet another, at 128 combinations, etc.) and the top 10 is a reasonable starting place.

We start by importing the results and creating a vector for the scenarios that we we can use as a label.

```         
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
```

Next, we create a temporary data frame sorted by our desired outcome.

```         
# select the final population for comparisons against policy 
# scenarios
results %>%
  mutate(Scenario = scenario) %>%
  filter(Years == 100) %>%
  mutate(`Final Population` = Population) %>%
  select(Scenario, `Final Population`) -> tmp
```

To look at the top ten senarios, we arrange the final values in decsendin order and print the top 10.

```         
# sort the results from highest to lowest and show
# the top 10 scenarios
tmp %>%
  arrange(desc(`Final Population`)) %>% head(10) 
```

It is often helpful to visualize the results in order of the desired impact of a strategy. This is useful for identifying patterns and cut-points in strategies to narrow the analysis. 

```         
tmp %>%
  arrange(`Final Population`) %>%
  mutate(Scenario=factor(Scenario, levels = Scenario)) %>%
  ggplot() + 
    geom_col(aes(x=`Final Population`,y=Scenario))
```

Doing this gives us the plot in Figure 1 where we see a jump in the outcome from strategy 0-0-1-1 to 0-1-1-1, which would suggest we might want to focus our subsequent analysis on the strategies with outcomes equal to or better than 0-1-1-1.

**Figure 1.** Strategies sorted by Final Population

![](images/clipboard-62566347.png)

## 4. Testing strategies and discounting ineffective interventions

# On your own

things that can be done beyond the exercise

# Some things to note

comments/notes

# References

any references

#' ## Exercise (work in groups)

#' Use `bechdel` data from package `fivethirtyeight`
#' Assume data are the entire population and obtain
#' - A sample of 60 movies that passed the Bechdel test and
#' - another sample of 72 movies that failed the Bechdel test
#' - Use set.seed(100) before obtaining your samples.
#'
#' We would like to the determine whether the movies that fail the Bechdel test are more profitable,
#' where profit = domgross - budget.
#'
#' 1. Obtain the R code to obtain the needed data.
#' 2. Answer the questions to determine whether this is a 1- or 2-sample test,
#'    the parameter(s) of interest, and the hypotheses
#' 3. Perform the test, obtain a test statistic, p-value, and conclude.
#'    Use the theory-based approach.
#' 4. Repeat 3 using the simulation-based approach.
#' 5. Obtain a 97% confidence interval for the average different in profit (pass - fail).
#'    Use the theory-based approach.
#' 6. Repeat 5 using a simulation-based approach.


#' Here is some code to get you started
#'

library(fivethirtyeight)
library(tidyverse)
library(infer)

set.seed(100)
df_pass <- bechdel |>
  na.omit() |>
  filter(binary == "PASS") |>
  slice_sample(n = 60) |>
  mutate(profit = domgross - budget)
df_fail <- bechdel |>
  na.omit() |>
  filter(binary == "FAIL") |>
  slice_sample(n = 72)|>
  mutate(profit = domgross - budget)

df_final <- rbind(df_pass, df_fail)

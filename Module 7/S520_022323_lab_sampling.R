#' Sampling
library(tidyverse)
library(moderndive)
library(infer)

bowl
n = 50
replic = 10^5

virtual_samples <- 
  bowl |>
  rep_sample_n(size = n, reps = replic)

virtual_prop_red <- 
  virtual_samples |>
  summarize(red = sum(color == "red")) |>
  mutate(prop_red = red / n)
virtual_prop_red

# Let's use the parameters from the population `bowl`
p = mean(bowl$color == "red")
mu = p
sigma = sqrt(p*(1-p)/n)

#' Using ggplot2
ggplot(virtual_prop_red, aes(x = prop_red)) + 
  geom_histogram(aes(y = ..density..), binwidth = 0.02) +
  stat_function(fun = dnorm, args = list(mean = mu, sd = sigma))

#' Using base R
hist(virtual_prop_red$prop_red, freq = F, breaks = seq(-0.01,0.7, by=0.02))
curve(dnorm(x, mu, sigma), add=T)




################################################################################
# Confidence Intervals
library(infer)
sam1 = gss$hours
xbar = mean(sam1)
s = sd(sam1)
n = length(sam1)

## Base R
# for the sample mean
n=500
alpha = 1 - 0.95
q = qt(1 - alpha/2, df = n-1)
q
xbar - q*(s/sqrt(n))
xbar + q*(s/sqrt(n))


# infer: using bootstrap
boot_dist <- gss %>%
  specify(response = hours) %>%
  generate(reps = 10000, type = "bootstrap") %>%
  calculate(stat = "mean")

percentile_ci <- get_ci(boot_dist, level = .95)
percentile_ci

visualize(boot_dist, bins = 100) +
  shade_confidence_interval(endpoints = percentile_ci)


# CI Proportion
## Base R
phat = mean(gss$sex == "female")
phat
SE.p = sqrt(phat*(1-phat)/n)
alpha = 1 - 0.98
q = qnorm(1 - alpha/2)
q

phat - q*SE.p
phat + q*SE.p

## Infer
boot_dist <- gss %>%
  specify(response = sex, success = "female") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "prop")

percentile_ci <- get_ci(boot_dist, level = .98)
percentile_ci

visualize(boot_dist) +
  shade_confidence_interval(endpoints = percentile_ci)

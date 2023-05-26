#' Lab 4-06-23 More examples of 2-sample problems
#' In This Lab
#' 1. Difference in Means
#' 2. Difference in Proportions
#' 3. Difference in Medians

library(infer)
library(tidyverse)
#View(gss)
#'
#' 1. Difference in Means
#'
#'
#'
View(gss)
degree = subset(gss, college == "degree")
no.degree = subset(gss, college == "no degree")
x = degree$age
y = no.degree$age
x
y
xbar =  mean(x)
ybar = mean(y)
s1 = sd(x)
s2 = sd(y)
n1 = length(x)
n2 = length(y)
se = sqrt(s1^2/n1 + s2^2/n2)

ts = (xbar - ybar - 0)/se
ts

nu.hat = (s1^2/n1+s2^2/n2)^2/((s1^2/n1)^2/(n1-1) + (s2^2/n2)^2/(n2-1))
nu.hat

2*(1 - pt(ts, nu.hat))

d_hat <- gss |>
  specify(age ~ college) |>
  calculate(stat = "diff in means", order = c("degree", "no degree"))

d_hat

null_dist <- gss |>
  specify(age ~ college) |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in means", order = c("degree", "no degree"))

visualize(null_dist) +
  shade_p_value(obs_stat = d_hat, direction = "two-sided")

null_dist |>
  get_p_value(obs_stat = d_hat, direction = "two-sided")

#' 2.1. Test of Significance: Difference in Proportions


d_hat <- gss |>
  specify(college ~ sex, success = "no degree") |>
  calculate(stat = "diff in props", order = c("female", "male"))

null_dist <- gss |>
  specify(college ~ sex, success = "no degree") |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in props", order = c("female", "male"))

visualize(null_dist) +
  shade_p_value(obs_stat = d_hat, direction = "two-sided")

null_dist |>
  get_p_value(obs_stat = d_hat, direction = "two-sided")

#' 2.2. Confidence Intervals: Difference in Proportions

bootstrap_dist <- gss |>
  specify(college ~ sex, success = "no degree") |>
  generate(reps = 1000, type = "bootstrap") |>
  calculate(stat = "diff in props", order = c("female", "male"))
bootstrap_dist

visualize(bootstrap_dist) +
  geom_vline(xintercept = 0)

bootstrap_dist |>
  get_confidence_interval(type = "percentile", level = 0.95)


### Theory-based

phat1 = sum(gss$sex == "female" & gss$college == "no degree")/sum(gss$sex == "female")
phat2 = sum(gss$sex == "male" & gss$college == "no degree")/sum(gss$sex == "male")

n1 = sum(gss$sex == "female")
n2 = sum(gss$sex == "male")

x = phat1*n1 # number of successes
y = phat2*n2

phat =(x+y)/(n1+n2) # pooled estimate of prop
se = sqrt((phat*(1-phat)*(1/n1+1/n2))) # This code has been updated:

alpha = 1- 0.95
q = qnorm(1-alpha/2)
(phat1 - phat2)-q*se
(phat1 - phat2)+q*se


#' 2.3. Confidence Intervals: Difference in Proportions (another example)

library(moderndive)
bootstrap_distribution_yawning <- mythbusters_yawn |>
  specify(formula = yawn ~ group, success = "yes") |>
  generate(reps = 1000, type = "bootstrap") |>
  calculate(stat = "diff in props", order = c("seed", "control"))
bootstrap_distribution_yawning
library(ggplot2)
visualize(bootstrap_distribution_yawning) +
  geom_vline(xintercept = 0)

bootstrap_distribution_yawning |>
  get_confidence_interval(type = "percentile", level = 0.95)


#View(mythbusters_yawn)

phat1 = sum(mythbusters_yawn$group == "seed" & mythbusters_yawn$yawn == "yes")/sum(mythbusters_yawn$group == "seed")
phat2 = sum(mythbusters_yawn$group == "control" & mythbusters_yawn$yawn == "yes")/sum(mythbusters_yawn$group == "control")

n1 = sum(mythbusters_yawn$group == "seed")
n2 = sum(mythbusters_yawn$group == "control")

x = phat1*n1 # number of successes
y = phat2*n2

phat =(x+y)/(n1+n2) # pooled estimate of prop
se = sqrt((phat*(1-phat)*(1/n1+1/n2))) # This code has been updated:

alpha = 1- 0.95
q = qnorm(1-alpha/2)
(phat1 - phat2)-q*se
(phat1 - phat2)+q*se

#' 3. Difference in Medians (only simmulation based)

d_hat <- gss |>
  specify(age ~ college) |>
  calculate(stat = "diff in medians", order = c("degree", "no degree"))


# Observe that the only difference with "means" is the `stat` argument in `calculate()`
null_dist <- gss |>
  specify(age ~ college) |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in medians", order = c("degree", "no degree"))

visualize(null_dist) +
  shade_p_value(obs_stat = d_hat, direction = "two-sided")

null_dist |>
  get_p_value(obs_stat = d_hat, direction = "two-sided")

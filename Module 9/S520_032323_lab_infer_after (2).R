#' # Infer
#' Based on material from https://infer.netlify.app/

#' Don't forget to install this library(only once) before running it
library(infer)
?gss
# View(gss)

#' ## Example 1


#' The claim is that the number of hours worked per week
#' is, on average, 40 hours. 
#' Does the data provide evidence against the claim?
#' 
#' \(H_0: mu = 40\)
#' \(H_1: mu != 40\)



#' ### Using theory-based approach

mu0 = 40
sample1 = gss$hours

xbar = mean(sample1)
s = sd(sample1)
n = length(sample1)

t = (xbar - mu0)/(s/sqrt(n))
t


2*(1-pt(t, n-1))



#' ### Simulation-based approach using infer

#' Infer code to find the sample mean 
x_bar <- gss |>
  specify(response = hours) |>
  calculate(stat = "mean")
x_bar

#' Generate bootstrap samples under the null distribution

null_sim <- gss |>
  specify(response = hours) |>
  hypothesize(null = "point", mu = 40) |>
  generate(reps = 10000, type = "bootstrap") |>
  calculate(stat = "mean")

#' Obtaining p-value based on the bootstrap samples

null_sim |>
  get_p_value(obs_stat = x_bar, direction = "two.sided")

#' Illustrating the problem with a plot

visualize(null_sim, method = "simulation", bins = 50) +
  shade_p_value(obs_stat = x_bar, direction = "two-sided")



#' ## Example 2
#' 
#' Claim: The proportion of college graduates is at least 0.4
#' 
#' \(H_0: p >= 0.40\)
#' \(H_1: p < 0.40\)


#Theory-based approach
phat = mean(gss$college == "degree")
phat
n = length(gss$college)
z = (phat - 0.4)/(sqrt(0.4*(1-0.4)/n))
z

pnorm(z)

#' Generate simulated samples under the null distribution

null_sim_p <- gss |>
  specify(response = college, success = "degree") |>
  hypothesize(null = "point", p = .4) |>
  generate(reps = 10000, type = "draw") |>
  calculate(stat = "prop")

#' Infer code to find the sample proportion

p_st <- gss |>
  observe(response = college, success = "degree", stat = "prop")
p_st


#' Obtaining p-value based on the simulated samples

null_sim_p |>
  get_p_value(obs_stat = p_st , direction = "left")

#' Illustrating the simulation with a plot

visualize(null_sim_p, method = "simulation") +
  shade_p_value(obs_stat = p_st, direction = "left")






#' ## Simulations of test statistics
#' These are not needed for testing but show some
#' relevant comparison with the theory based approach

#' ### Back to the Example 1 (Hours worked)
#' 
#' Using bootstrap to generate t-test statistics
#' assuming H_0 is true

null_sim_t <- gss |>
  specify(response = hours) |>
  hypothesize(null = "point", mu = 40) |>
  generate(reps = 10000, type = "bootstrap") |>
  calculate(stat = "t")

#' The observed test statistic (using infer)

t_bar <- gss |>
  observe(response = hours, null = "point", mu = 40, stat = "t")
t_bar

#' P-value

null_sim_t |>
  get_p_value(obs_stat = t_bar, direction = "two.sided")

#' Visualization

visualize(null_sim_t, method = "both", bins = 100) +
  shade_p_value(obs_stat = t_bar, direction = "two-sided")

#' Generate graph for theoretical value

null_sim_theory <- gss |>
  specify(response = hours)  |>
  assume("t")

visualize(null_sim_theory) +
  shade_p_value(obs_stat = t_bar, direction = "two.sided")


#' ### Back to the Example 2 (proportion college graduates)
#' 
#' Using simulated samples to generate z-test statistics
#' assuming H_0 is true

null_sim_z <- gss |>
  specify(response = college, success = "degree") |>
  hypothesize(null = "point", p = .4) |>
  generate(reps = 10000, type = "draw") |>
  calculate(stat = "z")

#' The observed test statistic (using infer)

z_st <- gss |>
  observe(response = college, success = "degree", null = "point", p = 0.4, stat = "z")
z_st

#' P-value

null_sim_z |>
  get_p_value(obs_stat = z_st , direction = "left")

#' Visualization

visualize(null_sim_z, method = "both") +
  shade_p_value(obs_stat = z_st, direction = "left")


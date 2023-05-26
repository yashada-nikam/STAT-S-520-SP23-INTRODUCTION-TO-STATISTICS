
################################################################################
## Example Goodness-of-fit: Fair Die

obs = c(3407, 3631, 3176, 2916, 3448, 3422)
n = sum(obs)
p = rep(1/6,6) #probabilities under the null
exp = n*p
exp

# The tests
X2 = sum((obs - exp)^2/exp)
X2 # Pearson's

G2 = sum(2*obs*log(obs/exp))
G2 # LRT

# P-values

df = (6 - 1) - 0

1 - pchisq(X2, df)
1 - pchisq(G2, df)

########################################
# Simulation-based test

# Preparing data frame first
die= as.character(1:6)
die.vec = rep(die,obs) #long-format
data1 = data.frame(die.vec) #making die.vec into a data frame


# Using data1 into infer (observe p is a vector of probabilities)

library(infer)

null_dist <- data1 |>
  specify(response = die.vec) |>
  hypothesize(null = "point", p = c("1" = 1/6, 
                                    "2" = 1/6, 
                                    "3" = 1/6, 
                                    "4" = 1/6, 
                                    "5" = 1/6, 
                                    "6" = 1/6)) |>
  generate(reps = 1000, type = "draw") |>
  calculate(stat = "Chisq")

null_dist |>
  get_p_value(obs_stat = X2, direction = "greater")



#######################
# Poisson example

obs = c(57, 203, 383, 525, 532, 408, 273, 139, 45, 27, 10, 4, 0, 1, 1)
alphacount = 0:14
n = sum(obs)
muhat = sum(alphacount*obs)/n        
muhat


## alternative way (closer to EX for a discrete RV)

x = 0:14
fx = obs/n
sum(x*fx)

# H0: The count of alpha-particle sintillations follow a Poisson
# H1: It does not


# Let's create our cells
# Ej = {j-1}, for j=1,2,..,10
# E11 = {10,11,12,...}
obs1 = c(obs[1:10], sum(obs[11:15]))

# Expected under the null
# argument lambda is the mu value for poisson
dpois(x = 0:9, lambda = muhat)
p11 = 1 - ppois(q = 9, lambda = muhat)
exp.p = c(dpois(x = 0:9, lambda = muhat), p11)
exp.p
sum(exp.p)
exp = exp.p*n
exp

chi2 = sum((obs1 - exp)^2/exp)
chi2

# K is the number of cells
df1 = 11 - 1
df0 = 1

df = df1 - df0
df

1 - pchisq(chi2, df)
# We fail to reject that the count of alpha-particle scintillations
# comes from a Poisson distribution



################################################################
## Example Independence: Crime

# Creating contingency table (6 rows and 2 columns)

obs <- matrix(c(50,88,155,379,18,63,43,62,110,300,14,144), 
             nrow = 6, ncol = 2)
rownames(obs) <- c("arson", "rape", "violence", 
                   "stealing", "coining", "fraud")
colnames(obs) <- c("drink", "abstain")
obs


#' Using the contingency table of observed counts
#' and the outer product to generate 
#' the table of expected counts

exp = rowSums(obs)%o%colSums(obs)/sum(obs)
exp

# The tests

# Pearson's
X2 = sum((obs - exp)^2/exp)
X2
df = (6 - 1)*(2 - 1)
1 - pchisq(X2, df)



# LRT
G2 = sum(2*obs*log(obs/exp))
G2
df = (6 - 1)*(2 - 1)
1 - pchisq(G2, df)

########################################
# Simulation-based test
# Preparing data frame first

library(tidyverse)

# turning table into long-format data frame (data2)
# Only needed when starting with a contingency table
# 'obs' in our case

df.obs = as.data.frame(obs)
data2 <- df.obs |>
  rownames_to_column("crime") |>            
  pivot_longer(cols=c('drink', 'abstain'),
               names_to='alcohol',
               values_to='count') |>
  rowwise() |> 
  mutate(count = list(1:count)) |>  
  unnest(count) |>                  
  select(-count)


# Test for independence using `data2`

library(infer)

null_dist <- data2 |>
  specify(alcohol ~ crime) |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "Chisq")

null_dist |>
  get_p_value(obs_stat = X2, direction = "greater")
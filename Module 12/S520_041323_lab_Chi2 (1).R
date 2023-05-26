n = 1611
obs = c(926, 288, 293, 104)
p0 = rep(1/4,4)  # probabilities under H_0
exp = n*p0
exp
chi2 = sum((obs - exp)^2/exp)
chi2

#H0: p1=p2=p3=p4=1/4

# finding the degrees of freedom
df1 = 4 - 1 #unrestricted
df0 = 0 # restricted

df = df1 - df0
df

# p-value

1 - pchisq(chi2, df)
# We reject the null

######
# Poisson example (Exercise 6)

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
# X ~ Normal(10, 4), that is EX=10, Var X  = 4, SD X = 2
# F(8) = P(X <= 8)
pnorm(q = 8, mean = 10, sd = 2)
pnorm(8, 10, 2)
# The function pnorm represent the CDF


curve(dnorm(x, 10, 2), from = 2, to = 18)
curve(dnorm(x, 8, 2), add = T, col="blue")
curve(dnorm(x, 8, 5), add = T, col="red")

# The dnorm represents
# the value of the PDF (the location of the y-axis value)
# f(8) is given by
dnorm(8, 10, 2)

# When you are finding areas, always use pnorm
# P(4 < X <= 8) = P(X<=8) - P(X<= 4) = F(8) - F(4)
pnorm(8, 10, 2) - pnorm(4, 10, 2)

# P(X >= 3) = 1 - P(X<3) = 1 - P(X <= 3) 1- F(3)
1 - pnorm(3, 10, 2)





# P(6 < X < 8)

## Random generation

vec = rnorm(10^5, 10, 2)
vec
df1 = data.frame(vec)
library(ggplot2)
ggplot(data = df1, mapping = aes(x = vec) )+geom_histogram(binwidth = 0.2)

# Back to X~Normal(10, 4)
pnorm(8, 10 ,2) # The theoretical probability
# logical operators
mean(vec <= 8) # An estimated probability (the proportion in the sample)



# Standardized values
vec.z = (vec - 10)/2
ggplot()+geom_histogram(mapping = aes(x = vec.z), binwidth = 0.2)

# Standard Normal
# Z ~ Normal(0,1)
curve(dnorm(x), from = -4, to = 4)

# P(-1 < Z < 1)
pnorm(1) - pnorm(-1)
# P(-2 < Z < 2)
pnorm(2) - pnorm(-2)
pnorm(3) - pnorm(-3)

# P(Z > 3) = 1 - P(Z <= 3) = 1 - F(3)
1 - pnorm(3)



## Random generation for binomial
# B-day party example
# Y ~ binomial(50, 0.8)
vec.b = rbinom(10^5, 50, 0.5)
df2 = data.frame(vec.b)
ggplot(data = df2, mapping = aes(x = vec.b) )+geom_histogram(binwidth = 0.2)



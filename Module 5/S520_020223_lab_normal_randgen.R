# X ~ Normal(10, 4), that is EX=10, Var X  = 4, SD X = 2
# F(8) = P(X <= 8)
pnorm(8, 10, 2)

curve(dnorm(x, 10, 2), from = 2, to = 18)


# P(6 < X < 8)

## Random generation

vec = rnorm(10^5, 10, 2)
vec
library(ggplot2)
ggplot()+geom_histogram(mapping = aes(x = vec), binwidth = 0.2)

vec.z = (vec - 10)/2
ggplot()+geom_histogram(mapping = aes(x = vec.z), binwidth = 0.2)


pnorm(8, 10 ,2)

# logical operators

mean(vec <= 8)

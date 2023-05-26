# X ~ Binomial(50, 0.8)

# f(30) = P(X = 30)
dbinom(x = 30, size = 50, prob = 0.8)
dbinom(30, 50, 0.8)

# F(30) = P(X <= 30)
pbinom(q = 30, size = 50, prob = 0.8)


# Exercise 1

# 1 - F(23)
1 - pbinom(q = 23, size = 50, prob = .8)

# F(39) - F(14)
pbinom(39, 50, 0.8) - pbinom(14, 50, 0.8)
  

# X ~ Poisson(3)

ppois(q = 4, lambda = 3)

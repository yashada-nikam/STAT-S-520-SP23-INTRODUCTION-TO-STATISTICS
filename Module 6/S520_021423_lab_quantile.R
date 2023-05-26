# Quantiles

qnorm(p = 0.6, mean = 10, sd = sqrt(25))

# 83th percentile of Normal(10,25)
qnorm(0.83, 10, sqrt(25))
qnorm(0.75, 10, sqrt(25)) - qnorm(0.25, 10, sqrt(25))


# Uniform

qunif(p = 0.6, min = 0, max = 2)
qunif(0.6, 0, 2)


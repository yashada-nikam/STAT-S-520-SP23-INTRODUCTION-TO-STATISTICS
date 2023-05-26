# ISI Ch8 exercise 3
n = 100
x = c(1,3,4,6)
fx = c(0.1, 0.4, 0.4, 0.1)
EX = sum(x*fx)
VarX = sum((x - EX)^2*fx)
c(EX, VarX)

#b
EXbar = EX
VarXbar = VarX/n

1 - pnorm(3.6, EXbar, sqrt(VarXbar))

# Let's run a simulation to check this result

vec = replicate(10^5, mean(sample(x, n, replace = T, prob = fx)))
mean(vec > 3.6)

## ISI Ch8 Exercise 6

EX = 0.01
VX = 0.01
EsumX  =400*EX
VsumX = 400*VX

EY = 0
VY = 0.25
EsumY  =400*EY
VsumY = 400*VY


1 - pnorm(0, EsumX, sqrt(VsumX)) #a
1 - pnorm(0, EsumY, sqrt(VsumY)) #b
1 - pnorm(20, EsumX, sqrt(VsumX)) #c
1 - pnorm(20, EsumY, sqrt(VsumY)) #d

# e. P(sumY > sumX) = P(sumY - sumX > 0)
1 - pnorm(0, EsumY - EsumX, sqrt(VsumY+VsumX)) #a

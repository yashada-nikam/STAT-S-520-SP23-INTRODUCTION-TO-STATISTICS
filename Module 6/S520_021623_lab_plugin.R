#' ---
#' title: "R Tutorial: Data"
#' author: "Arturo Valdivia"
#' date: "2/16/2023"
#' ---



#' # Table of Contents
#' 
#' -----------------------------------------------------------------------------
#' 
#' In this lab:
#' 
#' 1. Vectors
#'   
#'   1.1. Using scan()
#'   
#'   1.2. Pseudo-random generation from known distributions
#'   
#'   1.3. A pseudo-random sample from a vector
#'   
#' 2. Plug-in estimates
#' 
#' 3. Plots
#' 
#'   3.1. Using R base graphics
#'   
#'   3.2. Using ggplot2
#'   
#' 4. Simulations
#' 
#' 5. Functions
#' 
#' -----------------------------------------------------------------------------
#' 
#' to clear global environment use this code:
rm(list = ls())
#' libraries needed
library(ggplot2)

#' -----------------------------------------------------------------------------
#' 
#' ## 1.1. Vectors using scan()

#' Store the data in the same folder as your R file
#' and you can run the following code:
vec = scan('heights.txt')


#' Let's use the author's website 
x <- scan("https://mtrosset.pages.iu.edu/StatInfeR/Data/pulses.dat")


#' ### 1.2. Pseudo-random generation from known distributions
rnorm(30)
rnorm(30, mean = 10, sd = 2)
runif(20)
rbinom(25, size = 10, prob = 0.3)


#' ### 1.3. A random sample from a vector
vec
sample(x = vec, size = 10, replace = T)
#' or simply
sample(vec, 10, T)
set.seed(10) # seed to replicate the random sample
sample(vec, 10, T)



#' -----------------------------------------------------------------------------
#' 
#' ## 2. Plug-in Estimates

#' Let's use
x <- scan("https://mtrosset.pages.iu.edu/StatInfeR/Data/pulses.dat")

#' Let's construct the empirical probability distribution
#' 
#' pmf
n=length(x)
n
fx = rep(1,n) / n
fx

#' plug-in estimate for the expected value (mu.hat)
EX = sum(x * fx)
EX
mean(x)# mean(): the mean or sample average
median(x)# median(): median, 2nd quartile, or 0.5-quantile
quantile(x)# The 5-number summary
quantile(x, probs = 0.25) #q1 or 0.25-quantile
summary(x) # 5-number summary plus the mean
IQR(x) # IQR

#' plug-in estimate for the variance
VarX = sum ((x - EX)^2 * fx)
VarX
mean((x - mean(x))^2) # alt. formula 1
mean(x^2) - mean(x)^2 # alt. formula 2

sqrt(VarX) # Standard Deviation


#' Empirical CDF
EF = ecdf(x)
EF(60)

mean(x <= 60) #using logical operators


plot(ecdf(x))


#' -----------------------------------------------------------------------------
#' 
#' ## 3. Plots

#' ### 3.1. Using R base graphics

hist(x) # histogram
plot(density(x)) # kernel density estimate
boxplot(x) # boxplot

qqnorm(x) # Normal probability or QQ plot
qqline(x)

#' ### 3.2. Using ggplot2
#' We need x to be a variable in a data frame

data1 = data.frame(x = scan("https://mtrosset.pages.iu.edu/StatInfeR/Data/pulses.dat"))
#View(data1)

g1 = ggplot(data = data1, mapping = aes(x = x))

g1 + geom_histogram()
g1 + geom_density()
g1 + geom_boxplot()


g2 = ggplot(data = data1, mapping = aes(sample = x))
g2 + geom_qq() + geom_qq_line()

#' -----------------------------------------------------------------------------
#' 
#' ## 4. Simulations

my.vec = 1:20

#' We find the average of 30 numbers samples from my.vec
mean(sample(my.vec,30,replace = T))

#' Let's replicate this 15 times
replicate(n = 15,expr = mean(sample(my.vec,30,replace = T)))

#' We can store this average in a single vector
mean.vec = replicate(n = 15,expr = mean(sample(my.vec,30,replace = T)))
mean.vec

#' -----------------------------------------------------------------------------
#' 
#' ## 5. Functions
#' 
#' Let's construct a function to add two numbers
#' 
#' 
my.sum = function(a,b) a+b

my.sum(3,5)

#' Let's construct a function to generate a random sample of n numbers 
#' from a normal distribution with mean=mu and variance=sigma2 and find the ratio $iqr/\sigma$
#' 
#' 
my.ratio = function(n, mu, sigma2){
  sigma = sqrt(sigma2)
  x = rnorm(n, mu, sigma2)
  IQR(x)/sigma
}
my.ratio(n = 50, mu = 10, sigma2 = 25)

#' ---
#' title: "WLLN and CLT"
#' author: "Arturo Valdivia"
#' date: "2/21/2023"
#' ---

#' Let's first create some vectors x1, x2, and x3
#' Well assume these vectors are the random variables we'll use later on
N = 10^4
set.seed(101)
x1 = rbinom(N, 40, .1)
x2 = c(rnorm(N/2, 10, 3), rnorm(N/2, 2, 1))
red = as.numeric(moderndive::bowl$color == "red")
x3 = sample(red, N, replace = T)
x4 = c(rep(0,1000),1)

plot(density(x1, bw = .5))
plot(density(x2))
plot(density(x3))
plot(density(x4))


#' ## WLLN
#' Now, let's create a function to illustrate the WLLN (check 2/21/23 slides)
#' The key component is getting many replications of the sample mean


#' we then obtain the probability of the sample mean to be in the interval
#' mu - epsilon, mu + epsilon
wlln = function (x, n, N = 10^4, epsilon = 0.1){
  xbar.vec = replicate(N, mean(sample(x, n, replace = T)))
  lb = mean(x) - epsilon # lower bound
  ub = mean(x) + epsilon
  prob = mean(xbar.vec >= lb & xbar.vec <= ub)
  print(data.frame(n = n, probability = round(prob,2)))
} 


#' Now we can use our function to check the law of large numbers
#' You can change the 4 arguments as needed; observe that the key argument
#' is 'n' as the large n is the higher the probability that the sample mean
#' is in the small interval


wlln(x = x1, n = 10)
wlln(x = x1, n = 10^2) 
wlln(x = x1, n = 10^3) 
wlln(x = x1, n = 10^4) 

#' ## The Central Limit Theorem (CLT)
#' Similar to our previous function, the key component is the object xbar.vec
#' In addition, the function finds mu, mu_Xbar, sigma, sigma_Xbar, and a histogram
#' 
clt = function(x, n, N = 10^4){
  xbar.vec = replicate(N, mean(sample(x, n, replace = T)))
  op = par(mfrow = c(1,3))
  hist(xbar.vec, breaks = 100, 
       xlim = c(min(x), max(x)),
       xlab = paste("Sample mean (Xbar_n)"))
  plot(density(xbar.vec))
  qqnorm(xbar.vec);qqline(xbar.vec)
  par(op)
}


#' Again, change the argument values, in particular change n to see how the 
clt(x = x2, n = 1)
clt(x = x2, n = 10)
clt(x = x2, n = 30)
clt(x = x2, n = 100)

# Example Linear Regression

?faithful

plot(waiting ~ eruptions, data = faithful)

m1 = lm(waiting ~ eruptions, data = faithful)
summary(m1)

plot(waiting ~ eruptions, data = faithful)
abline(m1, col="red")

confint(m1)

# the current eruption lasted for 4 min
# what is the expected waiting time for the 
# next eruption?
# Let's obtain a 99% prediction interval
summary(faithful)
new.eruption = data.frame(eruptions = 4)
predict(object = m1, newdata = new.eruption, interval = "prediction", level = 0.99)

summary(faithful)

# We can also obtain the confidence interval for the expected waiting time for
# the next eruption, if the current eruption lasts for 4 min:
predict(object = m1, newdata = new.eruption, interval = "confidence", level = 0.99)

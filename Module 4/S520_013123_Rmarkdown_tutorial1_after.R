#' ---
#' title: "R Tutorial: Rscript into PDF"
#' author: "Arturo Valdivia"
#' date: "1/31/2023"
#' ---

#' Make sure to run this code (only the first time is needed) 
#' to install latex and write equations:
# tinytex::install_tinytex() 

#' Here is an example of how to write equations:
#' Let $X \sim binomial(50,0.8)$ and we want to find $$F(30) = P(X \le 30)$$
#' We can use R for that
#' We can add any other text here.
#'
pbinom(30, 50, 0.8)

#' Let's work with Modern Dive, CH3 data wrangling
#' 
#' 
library(dplyr)
library(ggplot2)
library(nycflights13)

#' ## Using 03-wrangling
#' ## -----------------------------------------------------------------------------
summary_temp <- weather %>% 
  summarize(mean = mean(temp, na.rm = TRUE), 
            std_dev = sd(temp, na.rm = TRUE))
summary_temp

#'
#'
## -----------------------------------------------------------------------------
summary_monthly_temp <- weather %>% 
  group_by(month) %>% 
  summarize(mean = mean(temp, na.rm = TRUE), 
            std_dev = sd(temp, na.rm = TRUE))
summary_monthly_temp

#' # Exercises

# Create a histogram for the temperature
ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram()


# Create a boxplot for the temperature
ggplot(data = weather, mapping = aes(y=temp)) +
  geom_boxplot()

# Create a boxplot for the temperature by month
ggplot(data = weather, mapping = aes(x = as.factor(month), y=temp)) +
         geom_boxplot()

# This is an R script
# We use a hash symbol to make comments that are not considered code

#############################################################################
# 1. R as calculator
#############################################################################

# To run any line click on the green arrow "Run"
# or press Control + Enter (Windows) or Command + Enter (apple)

3 + 4

(8 + 4)^2/3

4 +
7  

#############################################################################
# 2. Functions in R
#############################################################################

# Functions or commands perform tasks in R.
# R has many predefined functions from very simply to quite complex.
# (later on we'll learn to create our own functions too)
# Use parentheses after the function to include the arguments needed


# Here are some examples of simple functions:

log(34) # the natural log
exp(log(34)) # the Euler, or e, number (inverse of log)

sqrt(400) # square root
sqrt(5^2) # use hat for powers
400^(1/2)

# Some useful functions for counting
factorial(5) # factorial !
factorial(30)/factorial(30-3) # P(30,3)
factorial(30)/(factorial(3)*factorial(30-3)) #C(30,3)

choose(n = 30, k = 3) # C(n = 30,r = 3)
choose(30, 3)


#############################################################################
# 3. Assigning values to objects
#############################################################################

# We can create variables
# The object's name is written on the left-hand side (LHS) of the equal sign
# or "<-" symbol
# and the object you want to assign on the right-hand side (RHS)

a = 3 + 4
d = 12

b <- 4*d

# To print the value run the object
a
b

# Create your variables starting with a letter and follow by other letters, numbers,
# and underscores or periods. Object names are case-sensitive, so "a" and "A" are different
A

# Exercise: Create an object called "IU" and assign any number
# that represents for you some association with IU
# for example the number of courses taken this semester

IU =3
IU + a
IU/a

#############################################################################
# 4. Vectors
#############################################################################

# A vector is an ordered list of elements, like numbers
# To create a vector use "c()"

vec1 = c(1, 2, 3)
vec1
vec2 = 1:10

vec2

# To create sequences of values with distance not equal to 1
vec2a = seq(from = 1, to = 10, by = 0.5) # 

# We can use the function "sum()" to add numbers on a vector
sum(vec2)

# The sum of vectors using "+" is done component by component:
vec3 = 34:25
vec2 + vec3


long.vec = 101:200 #shortcut for a sequential vector
long.vec

very.long.vec = 1:20000
very.long.vec

# changing values inside a vector
long.vec[23:27]
long.vec[c(1,10, 28)]
long.vec[-c(1,10, 28)]

long.vec[70] <- 250
long.vec[70]
long.vec

#############################################################################
# 5. Data Frames
#############################################################################

# Data sets in R are called data frames

# By default, R has some data frames already
# To see them all run the following code:
data()

# Let's work with data frame "chickwts"
# To view the data frame use the function "View()"
View(chickwts)

# Existent data frames in R often have a description (use ? to view it)
?chickwts

# Each column is a variable and each row is an observation (or case)
# We can also use the function "dim()" for data frame dimensions

# To view important details we can use the function "summary()" or "str()"
summary(chickwts)

# To select a single column (variable) from a data frame use 
# the dollar sign "$". Let's select the variable "weight"
chickwts$weight 

# we can also create a new object with this variable
wt = chickwts$weight

# and the object "wt" is a (numeric) vector
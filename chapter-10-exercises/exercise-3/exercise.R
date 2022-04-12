# Exercise 3: working with built-in data sets

# Load R's "USPersonalExpenditure" dataset using the `data()` function
# This will produce a data frame called `USPersonalExpenditure`
data("USPersonalExpenditure")

# The variable `USPersonalExpenditure` is now accessible to you. Unfortunately,
# it's not a data frame (it's actually what is called a matrix)
# Test this using the `is.data.frame()` function
is.data.frame(USPersonalExpenditure)

# Luckily, you can pass the USPersonalExpenditure variable as an argument to the
# `data.frame()` function to convert it a data farm. Do this, storing the
# result in a new variable
USP <- data.frame(USPersonalExpenditure)

# What are the column names of your dataframe?
colnames(USP)

## Consider: why are they so strange? Think about whether you could use a number 
## like 1940 with dollar notation!

# What are the row names of your dataframe?
rownames(USP)

# Add a column "category" to your data frame that contains the rownames
USP$category <- rownames(USP)

# How much money was spent on personal care in 1940?
USP$X1940[USP$category == "Personal Care"]

# How much money was spent on Food and Tobacco in 1960?
USP$X1960[USP$category == "Food and Tobacco"]

# What was the highest expenditure category in 1960?
USP$category[USP$X1960 == max(USP$X1960)]
cat <- USP %>% filter(X1960 == max(X1960))

# Define a function `lowest_category` that takes in a year as a parameter, and
# returns the lowest spending category of that year
lowest_category <- function(year, USP){
  xyear <- paste0("X", year)
  res <- USP$category[USP[ , xyear] == min(USP[ , xyear])]
}

# Using your function, determine the lowest spending category of each year
# Hint: use the `sapply()` function to apply your function to a vector of years
print(lowest_category(1960, USP))
sapply(seq(1940, 1960, 5), lowest_category, USP)

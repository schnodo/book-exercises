# Exercise 4: practicing with dplyr

# Install the `"nycflights13"` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
rm(flights) # for resetting to initial state, just in case I goofed up
library(nycflights13)

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
nrow(flights)
ncol(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
colnames(flights)
flights2 <- mutate(flights, in_air_gain = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights2 <- arrange(flights2, desc(in_air_gain))

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
rm(list = ls())
flights2 <- flights %>% mutate(in_air_gain = arr_delay - dep_delay) %>% arrange(desc(in_air_gain))

# Make a histogram of the amount of time gained using the `hist()` function
hist(flights2$in_air_gain)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(flights2$in_air_gain, na.rm = TRUE)

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
SEA_flights <- flights2 %>% filter(dest == "SEA")

SEA <- data.frame(select(SEA_flights, origin),   
          select(SEA_flights, dest),   
          select(SEA_flights, in_air_gain)
)
SEA

# On average, did flights to SeaTac gain or loose time?
mean(SEA$in_air_gain, na.rm = TRUE)

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
filter(flights, origin == "JFK", dest == "SEA") %>%
  summarize(
    avg_air_time = mean(air_time, na.rm = TRUE),
    max_air_time = max(air_time, na.rm = TRUE),
    min_air_time = min(air_time, na.rm = TRUE)
  )

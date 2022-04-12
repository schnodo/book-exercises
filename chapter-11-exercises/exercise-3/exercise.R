# Exercise 3: using the pipe operator

# Install (if needed) and load the "dplyr" library
#install.packages("dplyr")
library("dplyr")

# Install (if needed) and load the "fueleconomy" package
#install.packages('devtools')
#devtools::install_github("hadley/fueleconomy")
library("fueleconomy")

# Which 2015 Acura model has the best hwy MGH? (Use dplyr, but without method
# chaining or pipes--use temporary variables!)
acura_2015 <- filter(vehicles, make == "Acura", year == 2015)
acura_2015 <- filter(acura_2015, hwy == max(hwy))
select(acura_2015, model)

# Which 2015 Acura model has the best hwy MPG? (Use dplyr, nesting functions)
acura_2015 <- select(
                filter(
                  filter(vehicles, make == "Acura", year == 2015),
                  hwy == max(hwy)), 
                model)
acura_2015

# Which 2015 Acura model has the best hwy MPG? (Use dplyr and the pipe operator)
vehicles %>% 
  filter(make == "Acura", year == 2015) %>% 
  filter(hwy == max(hwy)) %>% 
  select(model)

### Bonus

# Write 3 functions, one for each approach.  Then,
# Test how long it takes to perform each one 1000 times

acura_temp <- function() {
  acura_2015 <- filter(vehicles, make == "Acura", year == 2015)
  acura_2015 <- filter(acura_2015, hwy == max(hwy))
  select(acura_2015, model)  
}

acura_chain <- function() {
  select(
    filter(
      filter(vehicles, make == "Acura", year == 2015),
      hwy == max(hwy)), 
    model)
}

acura_pipe <- function() {
  vehicles %>% 
    filter(make == "Acura", year == 2015) %>% 
    filter(hwy == max(hwy)) %>% 
    select(model)
}

system.time(for (i in 1:1000) acura_temp())
system.time(for (i in 1:1000) acura_chain())
system.time(for (i in 1:1000) acura_pipe())

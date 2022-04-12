# Exercise 1: creating data frames

# Create a vector of the number of points the Seahawks scored in the first 4 games
# of the season (google "Seahawks" for the scores!)
scored <- c(12, 12, 30, 15)

# Create a vector of the number of points the Seahwaks have allowed to be scored
# against them in each of the first 4 games of the season
taken <- c(13, 25, 20, 35)

# Combine your two vectors into a dataframe called `games`
games <- data.frame(scored = scored, taken = taken)

# Create a new column "diff" that is the difference in points between the teams
# Hint: recall the syntax for assigning new elements (which in this case will be
# a vector) to a list!
games$diff <- scored - taken

# Create a new column "won" which is TRUE if the Seahawks won the game
games$won <- (games$diff > 0)

# Create a vector of the opponent names corresponding to the games played
opponents <- c("Wranglers", "Cheaters", "Robots", "Coast Guard")

# Assign your dataframe rownames of their opponents
rownames(games) <- opponents

# View your data frame to see how it has changed!
games

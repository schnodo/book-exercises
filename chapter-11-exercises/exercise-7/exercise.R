# Exercise 7: using dplyr on external data

# Load the `dplyr` library


# Use the `read.csv()` function to read in the included data set. Remember to
# save it as a variable.
setwd("e:/book-exercises/chapter-11-exercises/exercise-7/data")
nba <- read.csv("nba_teams_2016.csv")


# View the data frame you loaded, and get some basic information about the 
# number of rows/columns. 
# Note the "X" preceding some of the column titles as well as the "*" following
# the names of teams that made it to the playoffs that year.
head(nba)
colnames(nba)
length(nba)
nrow(nba)
ncol(nba)

# Add a column that gives the turnovers to steals ratio (TOV / STL) for each team
nba <- nba %>% mutate(tv_to_st = TOV / STL)

# Sort the teams from lowest turnover/steal ratio to highest
# Which team has the lowest turnover/steal ratio?
nba %>% arrange(tv_to_st) %>% filter(tv_to_st == min(tv_to_st)) %>% select(Team)

# Using the pipe operator, create a new column of assists per game (AST / G) 
# AND sort the data.frame by this new column in descending order.
nba %>% mutate(ass_pg = AST / G) %>% arrange(desc(ass_pg))

# Create a data frame called `good_offense` of teams that scored more than 
# 8700 points (PTS) in the season
good_offense <- nba %>% filter(PTS > 8700)
head(good_offense)

# Create a data frame called `good_defense` of teams that had more than 
# 470 blocks (BLK)
good_defense <- nba %>% filter(BLK > 470)
head(good_defense)

# Create a data frame called `offense_stats` that only shows offensive 
# rebounds (ORB), field-goal % (FG.), and assists (AST) along with the team name.
offense_stats <- nba %>% select(Team, ORB, FG., AST)
head(offense_stats)

# Create a data frame called `defense_stats` that only shows defensive 
# rebounds (DRB), steals (STL), and blocks (BLK) along with the team name.
defense_stats <- nba %>% select(Team, DRB, STL, BLK)
head(defense_stats)

# Create a function called `better_shooters` that takes in two teams and returns
# a data frame of the team with the better field-goal percentage. Include the 
# team name, field-goal percentage, and total points in your resulting data frame
better_shooters <- function(team1, team2) {
  nba %>% filter(Team == team1 | Team == team2) %>% 
        filter(FG. == max(FG.)) %>% 
        select(Team, FG., PTS)
}

# Call the function on two teams to compare them (remember the `*` if needed)
better_shooters("Golden State Warriors*", "Boston Celtic*")

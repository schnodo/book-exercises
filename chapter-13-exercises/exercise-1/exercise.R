# Exercise 1: accessing a relational database

# Install and load the `dplyr`, `DBI`, and `RSQLite` packages for accessing
# databases
install.packages("dbplyr")
library(dbplyr)
install.packages("DBI")
library(DBI)
install.packages("RSQLite")
library(RSQLite)
library(dplyr)
rm(list = ls())

# Create a connection to the `Chinook_Sqlite.sqlite` file in the `data` folder
# Be sure to set your working directory!
setwd("e:/book-exercises/chapter-13-exercises/exercise-1/data")
db_connection <- dbConnect(SQLite(), dbname = "Chinook_Sqlite.sqlite")
db_connection

# Use the `dbListTables()` function (passing in the connection) to get a list
# of tables in the database.
dbListTables(db_connection)

# Use the `tbl()`function to create a reference to the table of music genres.
# Print out the the table to confirm that you've accessed it.
g_tbl <- tbl(db_connection, "Genre")

# Try to use `View()` to see the contents of the table. What happened?
View(g_tbl)

# Use the `collect()` function to actually load the genre table into memory
# as a data frame. View that data frame.
df_g_tbl <- collect(g_tbl)
View(df_g_tbl)

# Use dplyr's `count()` function to see how many rows are in the genre table
count(g_tbl)

# Use the `tbl()` function to create a reference the table with track data.
# Print out the the table to confirm that you've accessed it.
t_tbl <- tbl(db_connection, "Track")
t_tbl

# Use dplyr functions to query for a list of artists in descending order by
# popularity in the database (e.g., the artist with the most tracks at the top)
# - Start by filting for rows that have an artist listed (use `is.na()`), then
#   group rows by the artist and count them. Finally, arrange the results.
# - Use pipes to do this all as one statement without collecting the data into
#   memory!

t_tbl %>% filter(is.na(Composer) == FALSE) %>% 
  group_by(Composer) %>% 
  count() %>% 
  arrange(desc(n))

# Use dplyr functions to query for the most popular _genre_ in the library.
# You will need to count the number of occurrences of each genre, and join the
# two tables together in order to also access the genre name.
# Collect the resulting data into memory in order to access the specific row of
# interest
popular_genre <- t_tbl %>% 
  group_by(GenreId) %>% 
  count() %>% 
  left_join(g_tbl, by = "GenreId") %>% 
  arrange(desc(n)) %>% 
  collect()

popular_genre

# Bonus: Query for a list of the most popular artist for each genre in the
# library (a "representative" artist for each).
# Consider using multiple grouping operations. Note that you can only filter
# for a `max()` value if you've collected the data into memory.

t_tbl %>% 
  filter(is.na(Composer) == FALSE) %>% 
  group_by(GenreId, Composer) %>% 
  count() %>% 
  left_join(g_tbl) %>% 
  select(Artist = Composer, Genre = Name, Count = n) %>% 
  group_by(Genre) %>% 
  collect() %>% 
  filter(Count == max(Count))

# Remember to disconnect from the database once you are done with it!
dbDisconnect(db_connection)

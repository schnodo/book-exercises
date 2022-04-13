# Exercise 2: working with data APIs

# load relevant libraries
library("httr")
library("jsonlite")

# Be sure and check the README.md for complete instructions!


# Use `source()` to load your API key variable from the `apikey.R` file you made.
# Make sure you've set your working directory!
setwd("e:/book-exercises/chapter-14-exercises/exercise-2/")
source("apikey.R")

# Create a variable `movie_name` that is the name of a movie of your choice.
movie_name <- "Tenet"

# Construct an HTTP request to search for reviews for the given movie.
# The base URI is `https://api.nytimes.com/svc/movies/v2/`
# The resource is `reviews/search.json`
# See the interactive console for parameter details:
# (Wrong URL!) https://developer.nytimes.com/movie_reviews_v2.json
# Correct URL: https://developer.nytimes.com/docs/movie-reviews-api/1/overview
#
# You should use YOUR api key (as the `api-key` parameter)
# and your `movie_name` variable as the search query!
nyt_base <- "https://api.nytimes.com/svc/movies/v2/"
nyt_res <- "reviews/search.json"

# Send the HTTP Request to download the data
# Extract the content and convert it from JSON
nyt_response <- GET(paste0(nyt_base, nyt_res), 
                    query = list("query" = movie_name, 
                                 "api-key" = nyt_apikey))
                    
View(nyt_response)
body <- content(nyt_response, "text")
nyt_list <- fromJSON(body)
print(nrow(nyt_list))
View(nyt_list)

# What kind of data structure did this produce? A data frame? A list?
class(nyt_list)

# Manually inspect the returned data and identify the content of interest 
# (which are the movie reviews).
# Use functions such as `names()`, `str()`, etc.
names(nyt_list)
str(nyt_list)

# Flatten the movie reviews content into a data structure called `reviews`
reviews <- flatten(nyt_list$results)
class(nyt_list$results)

# From the most recent review, store the headline, short summary, and link to
# the full article, each in their own variables
most_recent <- reviews[1, ]
headline <- most_recent$headline
short_summary <- most_recent$summary_short
article_url <- most_recent$link.url

# Create a list of the three pieces of information from above. 
# Print out the list.
list(headline = headline, 
     short_summary = short_summary, 
     article_url = article_url)

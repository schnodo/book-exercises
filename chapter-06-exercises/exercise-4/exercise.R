# Exercise 4: functions and conditionals

# Define a function `is_twice_as_long` that takes in two character strings, and 
# returns whether or not (e.g., a boolean) the length of one argument is greater
# than or equal to twice the length of the other.
# Hint: compare the length difference to the length of the smaller string
is_twice_as_long <- function(str1, str2){
  diff <-  abs(nchar(str1) - nchar(str2))
  smaller <- min(str1, str2)

  if (nchar(smaller) <= diff){
   return(TRUE) 
  }
  FALSE
}

# Call your `is_twice_as_long` function by passing it different length strings
# to confirm that it works. Make sure to check when _either_ argument is twice
# as long, as well as when neither are!
is_twice_as_long("123", "123123")
is_twice_as_long("123", "12312")
is_twice_as_long("123123", "123")
is_twice_as_long("12312", "123")

# Define a function `describe_difference` that takes in two strings. The
# function should return one of the following sentences as appropriate
#   "Your first string is longer by N characters"
#   "Your second string is longer by N characters"
#   "Your strings are the same length!"
describe_difference <- function(str1, str2){
  diff <-  nchar(str1) - nchar(str2)
  if(diff == 0){
    "Your strings are the same length!"
  }else{
    if(diff > 0){
      paste("Your first string is longer by", abs(diff), "characters")
    }else{
      paste("Your second string is longer by", abs(diff), "characters")
    }
  }
  
}

# Call your `describe_difference` function by passing it different length strings
# to confirm that it works. Make sure to check all 3 conditions1
describe_difference("123", "123123")
describe_difference("123", "12312")
describe_difference("123123", "123")
describe_difference("12312", "123")
describe_difference("123123", "123123")

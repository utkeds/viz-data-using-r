add_five <- function(x) {
  x + 5
}

1:10 %>% 
  map_dbl(add_five)

for (i in 1:10) {
  print(i + 5)
}

library(purrr)

# Define the function
add_five <- function(vector) {
  # Use map_dbl to apply the function (add 5) to each element and return a double
  result <- map_dbl(vector, function(x) x + 5)
  return(result)
}

# Create a vector (1:10)
my_vector <- 1:10

# Call the function with the vector
result_vector <- add_five(my_vector)

# Print the result
print(result_vector)


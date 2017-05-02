# Working with Data

# Set the working directory
setwd("C:/Users/HP/Downloads/kk/3-r-data-science-m3-exercise-files")

# Read a tab-delimited data file
cars <- read.table(
    file = "Cars.txt",
    header = TRUE,
    sep = "\t",
    quote = "\"")

# Peek at the data (displays the first six rows)
head(cars)

# Load the dplyr library
library(dplyr)

# Select a subset of columns
temp <- select(
    .data = cars, 
    Transmission,
    Cylinders,
    Fuel.Economy)
# . is used before data to avoid naming collision

# Inspect the results
head(temp)

# Filter a subset of rows
temp <- filter(
    .data = temp, 
    Transmission == "Automatic")
#last condition is called a "filter predicate"

# Inspect the results
head(temp)

# Compute a NEW column to append into the existing table
temp <- mutate(
    .data = temp, 
    Consumption = Fuel.Economy * 0.425)

# Inspect the results
head(temp)

#VERY IMPORTANT
# Group by a column
temp <- group_by(
    .data = temp,  
    Cylinders)
#The grouping category will now be 'CYlinders'
#See summarize for it's importance
    
# Inspect the results
head(temp)

# Aggregate based on groups
temp <- summarize(
    .data = temp, 
    Avg.Consumption = mean(Consumption))
#Note that it takes mean of consumptions values of each type in Cylinder category. (since, grouping category is given Cylinder)

# Inspect the results
head(temp)

# Arrange the rows in descending order
temp <- arrange(
    .data = temp, 
    desc(Avg.Consumption))

    
# Inspect the results
head(temp)

# Convert to data frame
efficiency <- as.data.frame(temp)
#Coercing table to a dataframe

# Inspect the results
print(efficiency);

#Alternatively we can chain all the above methods using a pipe operator
# Chain methods together
efficiency <- cars %>%
    select(Fuel.Economy, Cylinders, Transmission) %>%
    filter(Transmission == "Automatic") %>%
    mutate(Consumption = Fuel.Economy * 0.425) %>%
    group_by(Cylinders) %>%
    summarize(Avg.Consumption = mean(Consumption)) %>%
    arrange(desc(Avg.Consumption)) %>%
    as.data.frame()

# Inspect the results
print(efficiency)

# Save the results to a CSV file
write.csv(
    x = efficiency,
    file = "Fuel Efficiency.csv",
    row.names = FALSE)

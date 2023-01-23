### Entering the tidyverse (dplyr)
### 23 Jan 2023
### LHT

### tidyverse: collection of packages that share philosophy, grammar (or how the code is structured), and data structures

## Operators: Symbols that tell R to perform different operations (b/w variables, functions, etc.)

## Arithmetic operators: + - * / ^ ~

## Assignment Operator: <- 

## Logical Operators: ! & | 

## Relational Operators: == != > < >= <= 

## Miscellaneous Operators: %>% (forward pipe operator), %in$

library(tidyverse) #library function to load in packages 

# dplyr: new(er) package that provides a set of tools for manipulating data sets 
# specifically written to be fast 
# individual functions that correspond to common operartions 

#### The core verbs 
## filter()
## arrange()
## select()
## group_by() and summarize()
## mutate()

## built in dataset 

data(starwars)
class(starwars)
glimpse(starwars)

## Tibble: modern take on data frames 
# great aspects of data frames and drops frustrating ones (change variables)

### NAs 
anyNA(starwars) #is.na #complete.cases

starwarsClean <- starwars[complete.cases(starwars[,1:10]),] #taking out the NAs from the first 10 columns 

### filter(): picks/subsets observations (ROWS) by their values 

filter(starwarsClean, gender == "masculine" & height < 180) #fitler table for short and masculine characters NOTE ',' means AND

filter(starwarsClean, gender == "masculine", height < 180, height > 100) #this demonstrates multiple conditions for the same variable 

#### %in% operator (matching)
# similar to == but can compare vectors of different lengths
# sequence of letters

a <- LETTERS[1:10]
length(a)

b <- LETTERS[4:10]
length(b)

# output of the in operator depends on the 1st operator

a %in% b # checks if the b values are in a and gives logical value, gives 10 values  

b %in% a # gives 7 values 

# sue %in% to subset 

eyes <- filter(starwars, eye_color %in% c('blue', 'brown')) #returns all characters with eyecolors blue and brown
view(eyes)

## arrange(): reorders rows
arrange(starwarsClean, by=height) #default is ascending order, can use helper function desc() to reverse 
arrange(starwarsClean, by=desc(height))

arrange(starwarsClean, by=height, by=desc(mass)) # second variable breaks any ties

sw <- arrange(starwars, by=height) #arrange puts all NAs at bottom
tail(sw)

### select(): chooses variables 
#(COLUMNS) by their names
select(starwarsClean, 1:10)
select(starwarsClean, name:species) #only gives columns until species column 
select(starwarsClean, -(films:starships)) #takes away columns name-species 
select(starwarsClean, name, gender, species, everything()) # everything helpewr function is useful if you have a couple variables you want to move to the front 

# contains() helper function 
select(starwarsClean, contains('color')) #other helper functions include: ends_with(), starts_with(), num_range()

# select can also rename columns
select(starwarsClean, haircolor = hair_color) #only returns new coloumn, renamed
rename(starwarsClean, haircolor = hair_color) #returns whole table with column renamed

#mutate(): creates new variables using functions of existing variables

#create a new column that is height / mass 

mutate(starwarsClean, ratio = height/mass) #will make the last column ratio 

starwars_lbs <- mutate(starwarsClean, mass_lbs = mass * 2.2, .after=mass)
view(starwars_lbs) #can use the .after or .before function to move column instead of below code
starwars_lbs <- select(starwars_lbs, 1:3, mass_lbs, everything()) # putting mass_lbs towards the front of the table

#transmute
transmute(starwarsClean, mass_lbs = mass * 2.2) #only returns mutated columns
transmute(starwarsClean, mass, mass_lbs=mass*2.2, height) #returns mutated columns with the columns used to create it

### groupby() and summarize() functions
summarize(starwarsClean, meanHeight = mean(height)) #throws NA if any NA are in the column

summarize(starwarsClean, meanHeight = mean(height), TotalNumber = n()) # shows the sample used in the mean

#use group_by for maximum usefulness to compare subgroups in columns 
starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders)

summarize(starwarsGenders, meanHeight = mean(height, na.rm=T), TotalNumber=n())

# Piping %>%
# Used to emphasize a sequence of actions
# allows you to pass an intermediate result onto the next function (uses output of one function as input of the next function)
# avoid if you need to manipulate more than one object/variable at a time; or if variable is meaningful 
# formatting: should have a space before the %>% followed by the new line

starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight=mean(height, na.rm=T), TotalNumber=n()) #na.rm skips nas so you can take the mean, #much cleaner with piping

## case_when() is useful for multiple if/ifelse statements 

starwarsClean %>%
  mutate(sp = case_when
(species == "Human" ~ "Human", T ~ "Non-Human")) #uses condition, puts "Human" if True, puts "Non-Human" if F. 




### Programming in R
### Jan 12, 2022
### LHT 

## Advantages 

## interactive use
## graphics, statistics
## very active in community of contributers
## works on multiple platforms

## Disadvantages
## lazy evaluation 
## some packages are poorly documented
## funtions are hard to learn (steep learning curve)
## sometimes unreliable packages
## problems with big data (multiple GBs)

## Assignment operator: used to assign a new value to a variable 

##ex: 
x <- 5 
print(x) 
x
y=4 # legal but not used in function arguments 
print(y)
y <- y + 1.1 # does not use equal sign because arrow is more logical for override actiont
print(y)

# to comment out stuff retroactively highlight then hit command, shift, c 

## Variables: used to store information (a container)

z <- 3 #single letter variable can be fine if not that important 
plantHeight <- 10 #camel case format 
plant_height <- 3.3 # snake case format is prefered method bc easier to read
plant.height <- 4.2 # maybe avoid to avoid confusion with funtioncs
. <- 5.5 #reserved for temporary variable 

# Functions: blocks of code that performs a task; use short command over again instead of writing out that block of code multiple times 

# you can create your own function 

square <- function(x = NULL){ 
  
  x <- x^2
  print(x)

}
# NULL allows function not to run with no value 
 square(x=z)

 ## there are also built in functions 
 sum(109, 3, 10)
 
 ##R's four types of data
 # 1D - atomic vector - list 
 # 2D - matrix - data frame 
 
 ## Atomic Vectors 
 # one dimensional (a single row)
 # data structure in R programming 
 
 ### Types
 # character strings (usually within quotes)
 # integers (whole numbers)
 # double (real number and decimal)
 # both integers and doubles are generic
 # logical (true or false)
 # factor (categorizes, groups variables)
 
 # c function (combine)
 
z <- c(3.2, 5, 5, 6)
print(z)
class(z) #returns class of variable 
typeof(z) #returns type of variables
is.numeric(z) #gives true false 

#c() always "flattens" to a vector
z <- c(c(3,4), c(5,6))

# when combining different types of classes will reduce them all to characters

#character vectors 
z <- c("dog", "hat", "king")
print(z)
typeof(z)
class(z)
is.character(z) #is functions tests whether its a certain data type 

#as functions coerces data type
z <- c(T, F, T, F)
z <- as.character(z)
print(z)

#Length
length(z)
dim(z) #NULL because vectors are 1 dim 

#Names
z <- runif(5) #gives random unified randoms
names(z)

names(z) <- c("chow", "pug", "beagle", "greyhound", "akita")
print(z)
names(z) <- NULL 


### NAs stand for missing data 

z <- c(3.2, 3.5, NA)
typeof(z)
sum(z)

#check data for NAs
anyNA(z)
is.na(z)
which(is.na(z)) # gives index of data set for where the NA is

#Subsetting vectors 
#vectors are indexed 
z <- c(3.1, 9.2, 1.3, 0.4, 7.5)
z[4] #square brackets subset by index
z[c(4, 5)] #gives you two different values back 
z[-c(2,3)] #gives you everything except numbered elements
z[z==7.5] #only returns one that meets logical condition 
which(z==7.5) #returns the idex where this is true
z[which(z<7.5)] # gives the values 
z[z < 7.5] # gives the values
names(z) <- c("a", 'b', 'c', 'd', 'e')
print(z)

#subset
subset(x=z, subset=z>1.5)

# randomly sample 
# sample funtion 

story_vec <- c("A", 'frog', 'jumped', 'here')
sample(story_vec)
sample(story_vec, size=3)
story_vec <- c(story_vec[1], "Green", story_vec[2:4])
story_vec

#vector function
vec <- vector(mode = 'numeric', length=5)

##rep and seq function 
z <- rep(x=0, times=100)
z <- rep(x= 1:4, each=3)

z <- seq(from = 2, to=4)
z <- seq(from = 2, to=4, by=0.5)



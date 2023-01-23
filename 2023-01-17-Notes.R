### Vectors, Matrices, Data Frames, Lists 
### 17 Jan 2023
### LHT

### Vectors (cont'd)
### Properties

## Coercion 

## All atomic vectors are of the same data type 
## If you use c() to assemble different types, R coerces them
## logical -> integer -> double -> character 

a <- c(2, 2.2)

b <- c("purple", "green")

d <- c(a, b) 
typeof(d) #coerced to character

## comparison operators yield a logical result

a <- runif(10)
print(a)

a > 0.5 # conditional statement 

### how many elements in the vectors > 0.5

sum(a>0.5) # not summing actual values - its summing together the number of "trues" 
mean(a>0.5)


### Vectorization 
## add a constant to a vector

z <- c(10, 20, 30)
z + 1 # 11 21 31, adds to each component of the list 

## what happens when vectors are added together?

y <- c(1, 2, 3)

z + y # results in an element by element operation on the vection

## Recycling 

## What if Vector lengths are not equal? It will just go back to the start again. The shorter vector is always recycyled. 

z
x <- c(1, 2)
z + x

# Simulating data: runif() and rnorm()

runif(n=5, min=5, max=10) #sample size, min value, max value 

set.seed(123) #allows you to get same or different set of random numbers to sim data 
runif(n=100, min=5, max=10)
hist(runif(n=100, min=5, max=10)) 


#rnorm: random normal values with mean 0 and sd 1 
RNN <- rnorm(100)

#### Matrix data structure 
### 2 dimensional (rows and columns)
### homogenous data type

#matrix is an atomic vector organized into rows and columns 

my_vec <- 1:12 

m <- matrix(data = my_vec, nrow = 4)
m <- matrix(data = my_vec, ncol = 3)
m <- matrix(data = my_vec, ncol=3, byrow=T) # goes across horizontally 

### Lists 
## Are atomic vectors BUT each element can hold different data types (and different sizes)

myList <- list(1:10, matrix(1:8,nrow=4, byrow=T), letters[1:3], pi)
class(myList)
str(myList)

###subsetting lists 
## using [] gives you a single item BUT not the elements 

myList[4]
# cant do myList[4] -3 bc its giving back type not the object its self, need to use [[]]

myList[[4]] - 3

myList[[2]][4,1] #this is how to subset from the matrix

c(myList[[1]], myList[[2]]) # to get mult elements within list

### Name list items when they are created

myList2 <- list(Tester = F, littleM = matrix(1:9, nrow=3))
myList2$Testser

myList2$littleM[2,3] # extracts 2nd row and 3rd column of littleM 

myList2$littleM[2,] # leave blank if you want all elements [2, ] = second row all columns

myList2$littleM[2] # gives second element

## unlist to string everything back to vector

unRolled <- unlist(myList2)

data(iris)
head(iris)
plot(Sepal.Length ~ Petal.Length, data=iris) #asking how does sepal length relate to petal length using iris data y ~ x
model <- lm(Sepal.Length ~ Petal.Length, data=iris)
results <- summary(model) # we care about estimate (slope) and p values 

results$coefficients[2,4] #pull out p value from results, use the dollar sign if it is named

stats <- unlist(results$coefficients)
stats.1 <- unlist(stats)
stats.1[2,4]

unlist(results)$coefficients8 #p value is always titled coeffiecient 8


### Data Frames 
## (list of) equal length vectors, each of which is a column 

varA <- 1:12 
varB <- rep(c('Con', 'LowN', 'HighN'))
varC <- runif(12)

dFrame <- data.frame(varA, varB, varC, stringsAsFactors = F)
print(dFrame)


# add another row 
newData <- list(varA= 13, varB = 'HighN', varC = 0.668)


#use rbind

dFrame <- rbind(dFrame, newData)

#why can't we use c? why can't we use a list?
# c will coerce all to lowest type adn when it binds will and can coerce entire data frame

## add a column 

newVar <- runif(13)

#use cbind() funtion to add column 
dFrame <- cbind(dFrame, newVar)
head(dFrame) # gives you a preview 

### Data frames versus Matrices 
## data frames can have multiple types, matrix can only have 1

zMat <- matrix (data=1:30, ncol=3, byrow=T)

zDframe <- as.data.frame(zMat) #will coerce into new data
zDframe # dFrame will have column headers/labels and ids

##### Eliminating NAs
# complete.cases() function 

zD <- c(NA, rnorm(10), NA, rnorm(3))
complete.cases(zD) #gives logical output 

#clean out NAs

zD[complete.cases(zD)]
which(!complete.cases(zD)) # this tells us which is an NA
which(is.na(zD))

#use  with matrix

m <- matrix(1:20, nrow=5)
m[1:1] <- NA
m[5,4] <- NA
complete.cases(m) #gives T/F as to whether whole role is 'complete' (no NAs)
m[complete.cases(m),] # this only gives roles with out NAs
m[complete.cases(m[,1:2]),] #the complete cases of all the rows for columns 1 and 2, leaves columns 3 and 4 untouched 




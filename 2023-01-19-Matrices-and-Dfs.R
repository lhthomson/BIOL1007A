#### Finishing up Matrices and Data Frames 
#### 19 Jan 2023
#### LHT 

m <- matrix(data = 1:12, nrow=3)

## subsetting by elements 

m[1:2, ] #rows 1 and 2 with all columns

m[ , 2:4] #all rows, columns 2-4 

##subset with logical (conditional) statements 

## select all solumns for which totals are  > 15

colSums(m) > 15 # tells you what the columns will add up to 
m[, colSums(m) > 15] # gives it with values instaed of logical values

#rows sums now
#select rows that sum up to 22 
m[rowSums(m) == 22,] # need double equal sign because its a logical operator 
m[rowSums(m) != 22,] # everthing that does not equal 22 

# subsetting to  a vector changes the data types
z <- m[1,]
print(z)
str(z)

z2 <- m[1, , drop=F] # this will keep it as a matrix instead of turning it to a vector


#simulate new matrix
m2 <- matrix(data = runif(9), nrow = 3)


## use the assignment operator to substitute values 
m2[m2 < 0.6] <- NA # made any value above 0.6 an NA in the matrix 

data <- iris 
head(data)
tail(data)

dataSub <- data[c('Species', 'Petal.Length')]
str(dataSub)

### how to sort a data frame by values 
orderedIris <- iris[order(iris$Petal.Length),] # order iris data by petal length, include comma becuase we are telling to sort by the rows and give back all the columns
head(orderedIris)

#### Simple Data Analysis and More Complex Control Structures 
#### 30 January 2023 
#### LHT 

##load data

dryadData <- read.table(file="veysey_babbitt_amphibians.csv", header = T, sep = "," )

###Analyses
### Experimental designs 
### independent/explanatory variable(x-axis) vs dependent/repsponse variable (y-axis)
### continuous variables (range of numbers: height, weight, temperature) vs discrete/categorical variables (categories: species, treatments, site)


# x to y stat tests 
# continuous x to continuous y = regression with scatterplot 
# continuous x to categorical y = logistic regression 
# categorical x to categoical y = chi - squared (count), table, mosiac plot 
# categorical x to continuous y = t test for 2 groups, ANOVA for 2+ groups, bar graph or boxplot   

glimpse(dryadData)

#basic linear regression analysis(2 continuous variables)
## Is there a relationship between mean pool hydroperiod and the number of breeding frogs caught?
## y ~ x
regModel <- lm(count.total.adults ~ mean.hydro, data=dryadData)
print(regModel)
summary(regModel)
hist(regModel$residuals) # outliers? 
summary(regModel)$"r.squared" #extract r squared
summary(regModel)[["r.squared"]] #extract r squared

View(summary(regModel))

regPlot <- ggplot(data = dryadData, aes(x=mean.hydro, y=count.total.adults)) + geom_point() +
  stat_smooth(method="lm", se=0.99)
regPlot 

### Basic ANOVA
### Was there a statistically signnificant difference in the number of adults amonf wetlands?
#y~x
ANOmodel <- aov(count.total.adults ~ factor(wetland),data=dryadData)
summary(ANOmodel)

dryadData %>%
  group_by(wetland) %>%
  summarise(avgHydro = mean(count.total.adults, na.rm=T), N = n())

View(dryadData)
# Boxplot
dryadData$wetland <- factor(dryadData$wetland)

ANOplot <- ggplot(data=dryadData, mapping=aes(x=wetland, y=count.total.adults, fill = species)) +
  geom_boxplot() + 
  scale_fill_grey()

ANOplot

ggsave(file="SpeciesBoxplots.pdf", plot=ANOplot, device="pdf")

## logistic regression 
## data frame
## gamma probabilities - continuous variabilities that are always positive and ahve a skewed distribution 
xVar <- sort(rgamma(n=200, shape=5, scale=5))
xVar
yVar <- sample(rep(c(1,0), each=100), prob= seq_len(200))
yVar
logRegData <- data.frame(xVar, yVar)


## logistic regression analysis
logRegModel <- glm(yVar ~ xVar, data=logRegData, family=binomial(link=logit))
summary(logRegModel)

logRegPlot <- ggplot(data = logRegData, aes(x=xVar, y=yVar)) +
  geom_point() +
  stat_smooth(method = "glm", method.args = list(family=binomial))
logRegPlot

### Contingency table - chi squared analysis

countData <- dryadData %>% 
  group_by(species) %>%
          summarize(Males = sum(No.males, na.rm=T), Females = sum(No.females, na.rm=T))%>%
  select(-species)%>%
  as.matrix()
countData

# chi-squared
chisq.test(countData)$residuals #tells you theere are less than 2x the amount of species

## mosiacplot
mosaicplot(x=countData, col=c("goldenrod", "lightblue", shade= F))

##barplot


countDataLong <- countData %>% 
  as_tibble() %>%
  mutate(Species = c(rownames(countData))) %>%
  pivot_longer(cols = Males:Females, names_to = "Sex", values_to = "Count")
countDataLong
### Plot bar graph
countGraph <- ggplot(data = countDataLong, mapping=aes(x=Species, y=Count, fill=Sex)) +
  geom_bar(stat="identity", position="dodge") +
  scale_fill_manual(values=c("grey", "lightblue"))
countGraph

######################################################
# Control Structure 

# if and if else statements

### if statement
## if(condition) {expression 1}

##### if (condition) {expression} else {expression 2}

#### if (condition)(expression1) else {if (condition2) [expression2]} else {expression3}
#if and else should appear on the same line 

#use it for single values
z <- signif(runif(1), digits=2)
z > 0.5 

if (z > 0.8) {cat(z, "is a large numner", "\n")} else if (z < 0.2){cat(z, "is a small number", "\n")} else {cat(z, "is a number of typical size", "\n") 
  cat("z^2 =", z^2, "\n")}

#ifelse to fill vectors

### insect population where females lay 10.2 eggs on average, follows Poisson distribution (discrete probability distribution showing the likely number of times an event will occur) 35% parasitism where no eggs are laid, dist with 1000 individuals
hist(eggs)

#### for loops 
#### vector of p values from a simulation and we want to create a vector to highlight the significant ones for plotting 
pVals <- runif(1000)
z<-ifelse(pVals <= 0.025, "lowerTail", "nonSig")
z[pVals >= 0.975] <- "upperTail"
table(z)

### for loops
### workhorse function for doing repetetive tasks 
### controversial in R 
#### slow
#### often necessary (vectorization in R)
#### family of apply functions 
### for(variable in a sequence){#starts loop
#body of loop
#end of loop}
#var is a counter variable that holds the current value of the loops (i, j, k)
# seq is an integer vector that defines the start and end points of the loop 

for(i in 1:5){
  cat("stuck in a loop", i, "\n")
  cat(3+2, "\n")
  cat(3+i, "\n")
}
print(i)  

my_dogs <- c("chow", "akita", "husky", "malamute", "lab")

for(i in 1:length(my_dogs)){
  cat("i=", i, "my_dogs[i]=", my_dogs[i], "\n")
}

### use double for loops

# loops over rows
m <- matrix(round(runif(20), digits=2), nrow=5)

for(i in 1:nrow(m)){
  m[i,] <- m[i,] + i
}

#loops over columns
m <- matrix(round(runif(20), digits=2), nrow=5)
for(j in 1:ncol(m)){
  m[,j]<-m[,j] +1
}
m

#loops over rows and columns at the same time
m <- matrix(round(runif(20), digits=2), nrow=5)
for(i in 1:nrow(m)){
  for(j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  }
}

print(m)


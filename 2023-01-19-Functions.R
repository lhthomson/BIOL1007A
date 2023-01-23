#### FUNCTIONS IN R!
### 2023 JAN 19
#### LHT


##functionName <- function(argX = defaultX, argY=defaultY){

## Curly bracket starts the body of the function
## lines of R code ### and notes
## create local variables (only visible to R within the function)
## always end with a return(z)
#}

myFunc <- function(a=3, b=4){
  z <- a + b 
  return(z)
}
myFunc()
myFunc(a=100, b=3.4)


myFuncBad <- function(a=3){
  z <- a + b 
  return(z)
}

myFuncNULL <- function(a=NULL, b=NULL){
  z <- a + b 
  return(z)
} 
# no default number - instead with no number inputs they return integer(0)

### Multipl return statements

##########################################

# Function: HardyWeinberg
# Input: all allele frequency p (0,1)
#output: p and the frequencies of 3 genotypes AA AB BB
#----------------------------------------------------------

HardyWeinberg <- function (p = runif(1)){
  if(p > 1.0 | p< 0.0){
    return('Function failure: p must be between 0 and 1')
}
  q <- 1 - p 
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p, AA=fAA, AB=fAB,BB=fBB), digits=3)
  return(vecOut)
}

## Create a complex default value 
############################################
# Function: fitlinear2
# fits simple regression line
# input: list of predictor (x) and response (y)
# outputs: slope adn p-value


fitLinear2 <- function(p=NULL){ # allows you to input a list or if empty creates list
  if(is.null(p)){
    p <- list(x=runif(20), y=runif(20))
  }
  myMod <- lm(p$x~p$y)
  myOut <- c(slope = summary(myMod)$coefficients[2,1], pValue = summary(myMod)$coefficients[2,4])
  plot(x=p$x, y=p$y) 
  return(myOut)
}










#### ggplot2
#### jan 24 2023
#### LHT 

library(ggplot2)
library(ggthemes)
library(patchwork)

#### Template for ggplot code 

### ggplot(data=<DATA>, mapping = aes(x = xVar, y = yVar)) + 
### <GEOM FUNCTION> ##+ geom_boxplot()

### Load in a built-in data set 
data(mpg)
d <- mpg

library(dplyr)
glimpse(d)
qplot(x=d$hwy)

#histogram
qplot(x=d$hwy, fill= I("darkblue"), color =  I("black")) # I gives us the colors we want, color is the outline fill is the fill

#scatterplot
qplot(x=d$displ, y=d$hwy, geom=c("smooth", "point"), method = "lm")

# boxplot 
qplot(x=d$fl, y=d$cty, geom="boxplot", fill=I("forestgreen"))

#barplot 
qplot(x=d$fl, geom="bar", fill=I("forestgreen"))

#Create some data (specified counts)
x_trt <- c("Control", "Low", "High")
y_resp <- c(12, 2.5, 22.9)
qplot(x=x_trt, y=y_resp, geom ="col", fill=I(c("forestgreen", "slategray", "goldenrod")))


####: ggplot uses dataframes instead of vectors

p1 <- ggplot(data=d, mapping = aes(x=displ, y=cty, color = cyl)) +
  geom_point()
p1 

# how to change background, axis line, gridline, etc. 
p1 + theme_base()
p1 + theme_bw()
p1 + theme_classic()
p1 + theme_linedraw()
p1 + theme_dark()
p1 + theme_minimal()
p1 + theme_void()

p1 + theme_bw(base_size=20, base_family="serif")

p2 <- ggplot(data = d, aes(x=fl, fill=fl, )) +
  geom_bar()
p2 + coord_flip() + theme_classic(base_size = 15, base_family = "sans")#makes horizontal bar graph


# Theme modifications
p3 <- ggplot(data=d, aes(x=displ, y=cty)) + 
  geom_point(size=4, shape = 25, color = "magenta", fill="black") + 
  xlab("Count") + 
  ylab("Fuel") +
  labs(title="My title", subtitle="My subtitle") #x=, y=
p3 + xlim(1,10) + ylim(0, 35)

library(viridis)
cols <- viridis(7, option = "magma")
ggplot(data = d, aes(x=class, y=hwy, fill = class)) + 
  geom_boxplot() + 
  scale_fill_manual(values=cols)

library(patchwork)
p1 + p2 + p3 #next to eachother 
p1 / p2 / p3 # on top of eachother ]
(p1 + p2) / p3 



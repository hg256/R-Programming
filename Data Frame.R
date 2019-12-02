#DataFrames

#1. Built in data sets
women
data()
Titanic
head(state.x77,20)
tail(state.x77)
str(state.x77)
summary(state.x77)
state. 

#Make your own dataframes
days <- c('mon','tue','wed','thus','fri')
temp <- c(22,33,21,24,26)
rain <- c(T,F,F,T,T)

df <- data.frame(day =days,temperature =temp,Rain =rain) #change col names while creating df
df

c1 <- c(1:10)
c2 <- c(letters[1:10])
df1 <-data.frame(numbers =  c1, letter = c2)
df1

#subset function
subset(df,subset = rain == T)
subset(df,subset = temp>=24)

#Basic Operations
women
df2 <- women
df2
nrow(df2)
ncol(df2)
row.names.data.frame(df2)
colnames(df2)
mean(df2$bmi)

#Adding a new column
df2$bmi <- df2$height * df2$weight
df2

#Removing a column
df2$bmi <- NULL #equate it to null
str(df2)
summary((df2))

#Adding new row 
df3<- data.frame(height=90, weight = 200)
df3
dfnew <- rbind(df2,df3)
dfnew

#indexing and slicing
e <- df2[,'height']
is.data.frame(e)
f <- df2[,'height',drop = F]
f
is.data.frame(f)
df2[[3,2]] #single value selection
df2[1:5,1:2]
head(df2)
head(df2,10)
df2[-2,]

state.x77 # automic vector values
state <- as.data.frame(state.x77) #you can only use $ sign if its a data frame.
state$Income >5000 #you get boolean values.
state [state$Income>5000 | state$Illiteracy <1.4,, drop=F]

#Changing column name
colnames(dfnew)[2] <- 'WEIGHT'
dfnew


#converting first row names to column names (to plot)
install.packages("dplyr")
library(data.table)
setDT(state, keep.rownames = TRUE)[]
colnames(state)[1] <- 'States'
state


#qplot
#install.packages("ggplot2")
library(ggplot2)
?qplot
qplot(data = state, x = States, y= Murder, size = I(4), colour = I("red"))
qplot(data = state, x = Income, y= Illiteracy, size = I(4), 
      colour = Income , shape = I(18), alpha = I(0.6), main = "Title")
#alpha is the trasperency of the points ranges 0 to 1
qplot(1:10, rnorm(10), colour = runif(10))



#Merging DataFrames
#Merging df2 and df new
Mergedright <- merge(df2,dfnew, by.x = "height", all.y=T) #Right join
Mergedright
Mergedleft <-merge(df2,dfnew, by.x = "height", all.x = T) #Left join
Mergedleft
Mergedouter <-merge(df2,dfnew, by.x = "height", all = T) #Outer join
Mergedouter
#all = F is merged inner (inner join)



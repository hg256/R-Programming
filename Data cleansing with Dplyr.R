#Dplyr and Tidyr
install.packages("dplyr")
library("dplyr")
install.packages('nycflights13')
library("nycflights13")
head(flights)
str(flights)

# filter() to select subset of rows based on their values.
filter(flights, month == 11, day == 3, carrier == "AA")

#slice() We can select rows by position using slice()
slice(flights, 15:30)

# arrange() to reorder the cases in ascending order.
arrange(flights, day, month, year, desc(arr_delay), dep_time)

# select() and rename() to select only particular columns based on their names.
select(flights, carrier, arr_time, month)
rename(flights, arline.carrier = carrier)

#distinct gives out unique values of the column
distinct(flights,carrier)

# mutate() and transmute() to add new columns that are functions of existing columns
mutate(flights, new.col = arr_time - dep_delay)
transmute(flights, new.col = arr_time - dep_delay) #gives output of only new column

# summarise() to condense multiple values to a single value using aggregate function.
summarise(flights, mean.airtime = mean(air_time, na.rm = T))
summarise(flights, total.airtime = sum(air_time, na.rm = T))

# sample_n() and sample_frac() to take RANDOM samples.
sample_n(flights, 10) # gives number of rows mentioned
sample_frac(flights,0.2) # using percentage

#_________________Pipe Operator__________________________#

#Nesting
df <- mtcars
result <- arrange(sample_n(filter(df, mpg > 20),5), desc(mpg))
# the above can be written using multiple assignments
a <- filter(df, mpg > 20)
b <- sample_n(df,5)
result1 <- arrange(b,desc(mpg))
result1
# Now, using Pipe operator
result.new <- df %>% filter(mpg > 20) %>% sample_n(size = 5) %>% arrange(desc(mpg))
result.new

#--- Revision--#
# Return rows of cars that have an mpg value greater than 20 and 6 cylinders.
mtcars
filter(df, mpg>20, cyl == 6)

#Reorder the Data Frame by cyl first, then by descending wt.
head(arrange(df, cyl, desc(wt)))

#Select the columns mpg and hp
select(df, mpg,hp)
#Select the distinct values of the gear column.
distinct(df, gear)
#Create a new column called "Performance" which is calculated by hp divided by wt.
mutate(df, Performance = hp/wt)

#Find the mean mpg value using dplyr.
summarise(df, mean(mpg))

#Use pipe operators to get the mean hp value for cars with 6 cylinders.
df %>% filter(cyl ==6) %>% summarise(mean(hp))

### TIDYR ###
install.packages("tidyr")
install.packages("data.table")
library("tidyr")
library("data.table")

#gather - gathers data using  key and value column
#Spread - opposite of gather
comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)

df <- data.frame(comp=comp,year=yr,Qtr1 = q1,Qtr2 = q2,Qtr3 = q3,Qtr4 = q4)
df
?gather
res <- gather(df,Key,Revenue,Qtr1 : Qtr4)
res
res %>% spread(Key, Revenue)
#exqmple 2
stocks <- data.frame(
  time = as.Date('2009-01-01') + 0:9,
  X = rnorm(10, 0, 1),
  Y = rnorm(10, 0, 2),
  Z = rnorm(10, 0, 4)
)
stocks
stocksm <- stocks %>% gather(stock, price, -time)
stocksm
stocksm %>% spread(stock, price)
stocksm %>% spread(time, price)

#separate() turns a single character column into multiple columns. unite is the opposite
df <- data.frame(x = c(NA, "a.x", "b.y", "c.z"))
df
df %>% separate(x, c("ABC", "XYZ"))






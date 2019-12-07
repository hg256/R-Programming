# 1. Read & Write a csv file
read.csv("/Users/keerthi/Desktop/R Programming/P3-Future-500-The-Dataset.csv")
write.csv()

#Read and write excel file
install.packages("readxl") #package to read excel
library(readxl)
excel_sheets('path') #returns the names of all the sheets
x <- read_excel('name_of_the_Excel', sheet = 'sheet1')
install.packages('xlsx')
library(xlsx)


getwd()
setwd("/Users/keerthi/Desktop/R Programming")
fin <- read.csv("P3-Future-500-The-Dataset.csv")
# replace missing data to na while importing
fin <- read.csv("P3-Future-500-The-Dataset.csv",na.strings = c("","NAN"))
head(fin,20)
str(fin) #structure 
summary(fin)

# 2. changing from non factor to factor
str(fin$ID)
fin$ID <- factor(fin$ID)
fin$ID

summary(fin$Inception)
fin$Inception <- factor(fin$Inception)

#Changing from factor to numeric
#important - Convert to (charactor and then to numeric) factor or you'll end up getting the levels instead of integers
#Step 1 : wrong approach i.e convert to factor first and then to numeric
a <- c("11","12","14","12","11","11")
typeof(a)
b<- factor(a)
b
typeof(b) #integer
c <- as.numeric(b)
c # gives the levels not the integers
typeof(c)
#Step 2: Right approach i.e convert to character -> numeric
z <- factor(c("11","12","14","12","11","11"))
x <- as.numeric(as.character(z))
x
typeof(x)

# 3. sub and gsub() - replacement for single and all respectively
?gsub
str(fin$Expenses) #factor
fin$Expenses <- gsub("Dollars","",fin$Expenses)
fin$Expenses <- gsub(",","",fin$Expenses)
head(fin$Expenses)
str(fin$Expenses)


fin$Revenue
str(fin$Revenue)
fin$Revenue <- gsub("$","",fin$Revenue)
head(fin$Revenue) #in some cases "$" is a special character. Use escape seq (\\)
fin$Revenue <- gsub("\\$","",fin$Revenue)
fin$Revenue <- gsub(",","",fin$Revenue)

fin$Growth
fin$Growth <- gsub("%","",fin$Growth)

#gsub converted factor to character for us. Step 1 over. Now convert to numeric
fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Growth <- as.numeric(fin$Growth)
str(fin)

# 4. LOCATE MISSING VALUE
head(fin,24) #shows full or na rows ( T or F)
str(fin[!complete.cases(fin),]) # shows only na rows not all missing
fin[complete.cases(fin), ]

fin[fin$Employees == 45,] #includes NA while filtering
fin[which(fin$Employees == 45),] #which() gives the exact results for filtering

fin[is.na(fin$Industry),] #filters out NA
fin[!is.na(fin$Industry),] #opposite


# 5. REMOVE & REPLACE MISSING DATA IN PARTICULAR COLUMNS
fin <- fin[!is.na(fin$Industry),]

#Resetting the dataframe row index
str(fin)
rownames(fin) <- 1:nrow(fin) #option 1
fin
rownames(fin) <- NULL #option 2

# replacing missing data with factual analysis (common sense)
fin[is.na(fin$State),]
fin[is.na(fin$State) & (fin$City == "New York"), "State"] <- "NY"
fin[is.na(fin$State) & (fin$City == "San Francisco"), "State"] <- "CA"
fin[c(11,377,82,265),] #check

# Replacing data with Median Imputation Method
fin[!complete.cases(fin),]
#Employees
median(fin[,"Employees"], na.rm = T)
med.emp.retail <- median(fin[fin$Industry=="Retail","Employees"],na.rm = TRUE)
options(max.print=100000)
options("max.print")
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- med.emp.retail
med.emp.fin <- median(fin[fin$Industry=="Financial Services","Employees"],na.rm = TRUE)
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- med.emp.fin
fin[c(3,330),] #Check
#Growth
med.growth.const <- median(fin[fin$Industry=="Construction","Growth"],na.rm = TRUE)
med.growth.const 
fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- med.growth.const
#Revenue
fin[fin$Industry == "Construction","Revenue"]
fin[c(8,42),"Revenue"]
median(fin[fin$Industry == "Construction","Revenue"],na.rm = T)
med.const.rev <- median(fin[fin$Industry == "Construction","Revenue"],na.rm = T)
fin[is.na(fin$Revenue) & fin$Industry =="Construction","Revenue"] <- med.const.rev
#Expenses
fin[c(8,42),"Expenses"] <- NA
fin[fin$Industry == "Construction","Expenses"]
med.exp.constr <- median(fin[fin$Industry=="Construction","Expenses"],na.rm = TRUE)
med.exp.constr
fin[is.na(fin$Expenses) & fin$Industry =="Construction","Expenses"] <- med.exp.constr
fin[is.na(fin$Expenses) & fin$Industry =="Construction"& is.na(fin$Profit),"Expenses"] # so it catches only non calculable expneses i.e without profit

# Replacing data with derived values by calculating
#Expenses - Revenue - Profit
#Profit = Revenue - Expenses
fin[is.na(fin$Profit),"Profit"] <- fin[is.na(fin$Profit),"Revenue"] - fin[is.na(fin$Profit),"Expenses"]
fin[c(8,42,15),]
fin[is.na(fin$Expenses),"Expenses"] <- fin[is.na(fin$Expenses),"Revenue"] - fin[is.na(fin$Expenses),"Profit"]


fin[!complete.cases(fin),]

#Done



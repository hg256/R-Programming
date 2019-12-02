#Matrices
v1 <- c(1:5)
v2 <-c(6:8)
v3 <- c(9:15)
P <- matrix(c(v1,v2,v3),3,5)
P
v <-c(1:20)
v
matrix(v,4,5)

matrix(c(1:9),nrow = 3, ncol = 3, byrow = T)
matrix(v,4,5,byrow = T)

#rbind

rbind(v1,v2,v3)

c1 = c("one","two","three")
c2 = c("un","dos","tres")
c3 = c(1,2,3)

rbind(c1,c2,c3)

#cbind
k <- cbind(c1,c2,c3)
k

#NAmed vector

names(c3) <- c1
c3
names(c1) <- c("a","b","c")
c1
c1["c"] == c1[3]

#rownames and colnames
rownames(P) <- c("Sem1","Sem2","Sem3")
colnames(P) <- c("a","b","c","d","e")
P
P["Sem2","d"]
P[2,4]
P[1,]

#RowSums and ColSums
rowSums(P)
colSums(P)
rowMeans(P)
colMeans(P)


#Matrix Operations
FieldGoals
Games

new <- FieldGoals/Games
round(new,1) #rounds up the decimal numbers to 1 after the point.

help("matplot")
matplot(t(FieldGoals), type = "b", pch = 1:9, col = 1:9)
legend()

setwd("/cloud/project/Mod3")
getwd()

library(dplyr)

#Q1
df <- read.csv("getdata_data_ss06hid.csv")
df %>% filter(VAL == 24) %>% nrow() #53

table(df[,"VAL"] ==24)

sum(df$VAL==24,na.rm=1)


#Q3
library(xlsx)
dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx",
                 sheetIndex = 1,
                 rowIndex = 18:23,
                 colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T) #36534720

#Q4
library(XML)
df2 <- xmlTreeParse("getdata_data_restaurants.xml")
node <- xmlRoot(df2)
length(xpathApply(node,"//zipcode[.=21231]")) #127

df3 = xmlParse("getdata_data_restaurants.xml")
rootnode <- xmlRoot(df3)
df3 = xmlToDataFrame(rootnode[[1]])
df3 %>% filter(zipcode == 21231) %>% nrow() #127

#Q5
library(data.table)
DT <- fread("getdata_data_ss06pid.csv")
fast <- list()

ptm <- proc.time()
opt1a <- mean(DT[DT$SEX==1,]$pwgtp15); opt1b <-mean(DT[DT$SEX==2,]$pwgtp15)
t <- proc.time()- ptm; t
fast[1] <- t[[1]]

ptm <- proc.time()
opt2 <- tapply(DT$pwgtp15,DT$SEX,mean)
t <- proc.time()- ptm; t
fast[2] <- t[[1]]

ptm <- proc.time()
opt3 <- DT[,mean(pwgtp15),by=SEX]
t <- proc.time()- ptm; t
fast[3] <- t[[1]]

ptm <- proc.time()
opt4a <- rowMeans(DT)[DT$SEX==1]; opt4b <- rowMeans(DT)[DT$SEX==2]
t <- proc.time()- ptm; t
fast[4] <- t[[1]]

ptm <- proc.time()
opt5 <- sapply(split(DT$pwgtp15,DT$SEX),mean)
t <- proc.time()- ptm; t
fast[5] <- t[[1]]

ptm <- proc.time()
opt6 <- mean(DT$pwgtp15,by=DT$SEX)
t <- proc.time()- ptm; t
fast[6] <- t[[1]]

order(unlist(fast)) #6
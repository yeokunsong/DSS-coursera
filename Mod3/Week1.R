library(dplyr)

#Q1
df <- read.csv("Mod3//getdata_data_ss06hid.csv")
data <- as_tibble(df)

data %>% filter(VAL == 24) %>% nrow() #53

#Q3
library(xlsx)
dat <- read.xlsx("Mod3//getdata_data_DATA.gov_NGAP.xlsx",
                 sheetIndex = 1,
                 rowIndex = 18:23,
                 colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T) #36534720

#Q4
library(XML)
df2 <- xmlTreeParse("Mod3//getdata_data_restaurants.xml")
node <- xmlRoot(df2)
length(xpathApply(node,"//zipcode[.=21231]")) #127

#Q5
library(data.table)
DT <- fread("Mod3//getdata_data_ss06pid.csv")
fast <- list(0)

ptm <- proc.time()
opt1a <- mean(DT[DT$SEX==1,]$pwgtp15); opt1b <-mean(DT[DT$SEX==2,]$pwgtp15)
t <- proc.time()- ptm; t
fast <- append(fast, t[[1]])

ptm <- proc.time()
opt2 <- tapply(DT$pwgtp15,DT$SEX,mean)
t <- proc.time()- ptm; t
fast <- append(fast, t[[1]])

ptm <- proc.time()
opt3 <- DT[,mean(pwgtp15),by=SEX]
t <- proc.time()- ptm; t
fast <- append(fast, t[[1]])

ptm <- proc.time()
opt4a <- rowMeans(DT)[DT$SEX==1]; opt4b <- rowMeans(DT)[DT$SEX==2]
t <- proc.time()- ptm; t
fast <- append(fast, t[[1]])

ptm <- proc.time()
opt5 <- sapply(split(DT$pwgtp15,DT$SEX),mean)
t <- proc.time()- ptm; t
fast <- append(fast, t[[1]])

ptm <- proc.time()
opt6 <- mean(DT$pwgtp15,by=DT$SEX)
t <- proc.time()- ptm; t
append(fast, t[[1]])

fast
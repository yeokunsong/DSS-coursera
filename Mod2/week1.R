#Q11-20

setwd("/cloud/project/Mod2")

dat <- download.file('https://d396qusza40orc.cloudfront.net/rprog/data/quiz1_data.zip', destfile ="quizdat.zip")
dat <- unzip("quizdat.zip")
dat <- read.csv("hw1_data.csv")

#11-15
names(dat)
dat[1:2,]
nrow(dat)
tail(dat,2)
dat$Ozone[47]

#16-17
sum(is.na(dat$Ozone))
mean(dat$Ozone,na.rm=1)

#18
dat_1 = dat[dat$Ozone >31 & dat$Temp >90,]
mean(dat_1$Solar.R,na.rm=1)

#19
dat_2 = dat[dat$Month==6,]
mean(dat_2$Temp)

#20
dat_3 = dat[dat$Month==5,]
max(dat_3$Ozone,na.rm =1)

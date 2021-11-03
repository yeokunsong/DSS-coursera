setwd("/cloud/project/Mod3")

#Q1
library(httr)
library(utils)

DATAPATH = "https://api.github.com/users/jtleek/repos"
dat = GET(DATAPATH)
dat = content(dat)

for (repo in dat) {
  if(repo$name == "datasharing") {print (repo$created_at)}
}

#########################

#Q2 & Q3
library(sqldf)
acs = read.csv("getdata_data_ss06pid.csv")
sqldf("select * from acs where AGEP<50")
all(sqldf("select distinct AGEP from acs") == unique(acs$AGEP))

#Q4
url = "http://biostat.jhsph.edu/~jleek/contact.html"
con = url(url)
html = readLines(con)
for (i in c(10,20,30,100)) {
  print(nchar(html[i]))
}

#Q5
con = url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
df = read.fwf(con,skip = 4,widths = c(28,4)):head(df)
close(con)
sum(df$V2)

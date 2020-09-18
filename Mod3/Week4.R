#Q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "Mod3/w4q1.csv")
community <- read.csv("Mod3/w4q1.csv")
commNames <- names(community)
splitNames <- strsplit(commNames,"wgtp")
splitNames[123]

#Q2
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
con <- url(url)
GDP <- read.csv(con, skip = 4, nrows = 190)
mean(as.numeric(gsub(",","",GDP$X.4)))

#Q3
countryNames <- GDP$X.3
length(grep("^United",countryNames))

#Q4
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
con <- url(url)
edu <- read.csv(con)
t <- grepl(": June.*;",edu$Special.Notes)
length(edu$Special.Notes[t])

#Q5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
df2012 <- sampleTimes[grepl("2012-",sampleTimes)]; length(df2012)
df2012wd <- sapply(df2012,weekdays)
sum(grepl("Monday",df2012wd))

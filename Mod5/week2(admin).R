setwd("~/DSS-coursera/Mod5")

URL = "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
temp = tempfile()
download.file(URL,destfile = temp)
unzip(temp,"activity.csv")

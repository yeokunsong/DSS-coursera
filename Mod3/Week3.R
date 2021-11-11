#q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "getdata_data_ss06hid.csv")
df1 <- read.csv("getdata_data_ss06hid.csv"); dim(df1)
agricultureLogical <- (df1$ACR==3 & df1$AGS==6)
which(agricultureLogical)

#q2
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              destfile = "getdata_jeff.jpg")
pic2 <- readJPEG("getdata_jeff.jpg",native = TRUE)
quantile(pic2,c(0.3,0.8))

#q3
library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "getdata_data_GDP.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile = "getdata_data_EDSTATS_Country.csv")

df3a <- read.csv("getdata_data_GDP.csv",skip=4,nrows = 190); head(df3a); tail(df3a)
df3b <- read.csv("getdata_data_EDSTATS_Country.csv"); head(df3b[1:3])


df3a$X.4 <- as.numeric(gsub(",","",df3a$X.4)); head(df3a)
df3a$X.1 <- as.numeric(df3a$X.1)

m0 <- merge(df3a,df3b,by.x = "X",by.y = "CountryCode",all=FALSE); head(m0)[1:15]
m0$X.1 <- as.numeric(m0$X.1)

dim(m0)
tail(arrange(m0,desc(X.1)))[1:5]
arrange(m0,desc(X.1))[13,1:5]


#q4
m0 %>% 
  group_by(Income.Group) %>% 
  summarise(avg.rank = mean(X.1,na.rm=TRUE)) %>% 
  as.data.frame()

#q5
m0$cut <- cut(m0$X.1,5)
table(m0$cut,m0$Income.Group)

#q1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile = "Mod3/w3q1.csv")
df1 <- read.csv("Mod3/w3q1.csv"); dim(df1)
agricultureLogical <- (df1$ACR==3 & df1$AGS==6)
which(agricultureLogical)

#q2
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
              destfile = "Mod3/w3q2.jpg")
pic2 <- readJPEG("Mod3/w3q2.jpg",native = TRUE)
quantile(pic2,c(0.3,0.8))

#q3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
              destfile = "Mod3/w3q3_1.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
              destfile = "Mod3/w3q3_2.csv")
df3a <- read.csv("Mod3/w3q3_1.csv",skip=4,nrows = 190); head(df3a)
df3a$X.4 <- as.numeric(gsub(",","",df3a$X.4)); head(df3a)
df3a$X.1 <- as.numeric(df3a$X.1)
df3b <- read.csv("Mod3/w3q3_2.csv"); head(df3b[1:3])
m0 <- merge(df3a,df3b,by.x = "X",by.y = "CountryCode",all=FALSE); head(m0)
m0$X.1 <- as.numeric(m0$X.1)
arrange(m0,X.4)$Table.Name[13]

#q4
m0 %>% 
  group_by(Income.Group) %>% 
  summarise(avg.rank = mean(X.1,na.rm=TRUE)) %>% 
  as.data.frame()

#q5
m0$cut <- cut(m0$X.1,5)
table(m0$cut,m0$Income.Group)[1,"Low income"]

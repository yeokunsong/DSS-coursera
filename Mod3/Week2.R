#Q1
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "be15f58fc14abc7a57a8",
                   secret = "baebc97d672a972f7353abf1bbd2c53d7f5d6130"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)

#########################
#########################
#########################

#Q2 & Q3
library(sqldf)
acs = read.csv("Mod3/getdata_data_ss06pid.csv")

#Q4
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(url)
html <- readLines(con)
for (i in c(10,20,30,100)) {
  print(nchar(html[i]))
}

#Q5
con <- url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for")
df <- read.fwf(con,skip = 4,widths = c(28,4))
close(con)
sum(df$V2)

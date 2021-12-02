NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

str(NEI)

library(ggplot2)
library(dplyr)

#Q1
#Have total emissions from PM2.5 decreased in the United States from 1999 to
#2008? Using the base plotting system, make a plot showing the total PM2.5
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.

q1 = NEI %>%
  group_by(year) %>%
  summarise(SUM = sum(Emissions)) %>%
  select(year,SUM)

plot(q1)
barplot(q1$SUM,q1$year
        , main = "Q1: Total Emissions decrease over time"
        ,names.arg = q1$year)

#Q2Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
#plot answering this question.

table(q2$Pollutant) #only have PM2.5

q2=NEI %>%
  filter(fips=="24510",) %>%
  mutate(year=factor(year)) %>%
  group_by(year) %>%
  summarise(SUM = sum(Emissions)) %>%
  select(year,SUM)

plot(q2,main = "Q2: Maryland's emissions are falling over time")
lines(q2)

#Q3 Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

q3=NEI %>%
  filter(fips=="24510",) %>%
  mutate(year=factor(year)) %>%
  group_by(year,type) %>%
  summarise(SUM = sum(Emissions)) %>%
  select(year,type,SUM)

g = ggplot(q3, aes(year,SUM,group=type))
g = g + geom_line(aes(color=type)) + geom_point() 
g + ggtitle("All sources show decreasing trend, except POINT which saw a spike in 2005")
                                          
              
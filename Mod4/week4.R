NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#str(NEI)

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

plot(q1
     ,main = "Q1: Total Emissions decrease over time"
     ,xaxt="n")
axis(1,at=c(q1$year))
lines(q1$year,q1$SUM)


#Q2Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
#plot answering this question.

q2=NEI %>%
  filter(fips=="24510",) %>%
  group_by(year) %>%
  summarise(SUM = sum(Emissions)) %>%
  select(year,SUM)

barplot(q2$SUM,q2$year
        ,main = "Q2: Maryland's emissions are falling over time, with spike in 2005"
        ,names.arg = q2$year)

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
g + ggtitle("All sources show decreasing trend, except POINT which rose before seeing a dip in 2008")

#Q4 Across the United States, how have emissions from 
#coal combustion-related sources changed from 1999-2008?         

#Subset NEI dataset to get coal-related SCC
SCC.coal = SCC[grepl("Coal",SCC$EI.Sector),]
NEI.coal = NEI[NEI$SCC %in% SCC.coal$SCC, ]
  
ggplot(NEI.coal, aes(x = factor(year), y = Emissions)) + 
  geom_bar(stat= "identity") +
  ggtitle("Emissions from coal sources are dropping")

#Q5 How have emissions from motor vehicle sources changed 
#from 1999-2008 in Baltimore City?

SCC.mv = SCC[grepl("Vehicles",SCC$EI.Sector),]
NEI.mv = NEI[NEI$SCC %in% SCC.mv$SCC & NEI$fips=="24510", ]

ggplot(NEI.mv, aes(x = factor(year), y = Emissions)) + 
  geom_bar(stat= "identity") +
  ggtitle("Emissions from motor vehicle sources in Baltimore are dropping")

#Q6 Compare emissions from motor vehicle sources in Baltimore City with 
#emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions? 

NEI.mv2 = NEI[NEI$SCC %in% SCC.mv$SCC & 
                (NEI$fips=="24510" | NEI$fips=="06037"), ]
NEI.mv2$fips = as.factor(NEI.mv2$fips)
levels(NEI.mv2$fips) = c("California","Baltimore")

ggplot(NEI.mv2, aes(x = factor(year), y = Emissions, fill = fips)) + 
  geom_bar(stat= "identity", position="dodge") +
  facet_grid(fips ~ .) +
  ggtitle ("California's spike in motor vehical emission is much larger than the Baltimore's drop")

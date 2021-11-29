setwd("~/DSS-coursera/Mod4")

URL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(URL,"exdata_data_household_power_consumption.zip")
unzip("exdata_data_household_power_consumption.zip")

data = read.table("household_power_consumption.txt"
                  , header = 1
                  ,na.strings = "?"
                  ,sep = ";"
                  ,nrows = 69516
                  )

#To figure out the least no. of rows to read 
# and then update read.table function 
max(which(data[,1]=="2/2/2007")) #69516

data = subset(data, data[,1]== "1/2/2007" | data[,1]== "2/2/2007")


#Plot1
#Global Active Power: Frequency ~ Global Active Power (kilowatts)
png("plot1.png", width=480, height=480)
hist(data$Global_active_power
     ,col = "red"
     ,main = "Global Active Power"
     ,xlab = "Global Active Power (kilowatts)")
dev.off()


#Plot2
#Global Active Power (kilowatts) ~ Day
data$FDT = paste(data[,1],data[,2])
data$FDT = strptime(data$FDT, "%d/%m/%Y %H:%M:%S")
plot(data$FDT,data$Global_active_power
     ,type="l"
     ,xlab=""
     ,ylab="Global Active Power (kilowatts)"
     )

#Plot3
# Energy Sub metering ~ day
plot(data$FDT, data$Sub_metering_1
     ,type="l"
     ,xlab=""
     ,ylab="Energy sub metering")
lines(data$FDT, data$Sub_metering_2
      ,col="red"
      )
lines(data$FDT, data$Sub_metering_3
      ,col="blue"
      )
legend("topright"
       ,c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       ,lty= 1, lwd=2, col = c("black", "red", "blue"))

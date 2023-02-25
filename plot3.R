library(dplyr)
library(data.table)

#read-in data

data <- data.table(read.delim("household_power_consumption.txt", header = T, sep = ";"))
str(data)

#create date time variable

data$date_time <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

#convert Date from character to date

data$Date <- as.Date.character(x = data$Date, format = "%d/%m/%Y")
str(data)

#filter data (keep data from 2007-02-01 and 2007-02-02)

data <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

#create plot (submeter 1, 2, & 3 on y axis, day on x-axis)

png(file = "plot3.png", width = 480, height = 480)

with(data, plot(x = date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering"))
points(data$date_time, data$Sub_metering_2, type = "l", col = "red")
points(data$date_time, data$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

dev.off()

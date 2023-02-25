library(dplyr)
library(data.table)

#read-in data

data <- data.table(read.delim("household_power_consumption.txt", header = TRUE, sep = ";"))

str(data)

#create date time variable

data$date_time <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

#convert date variable to class date

data$Date <- as.Date.character(data$Date, format = "%d/%m/%Y")

str(data)

#filter data (need to keep 2007-02-01 and 2007-02-02)

data <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

#create plot

png(file = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

with(data, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))

with(data, plot(date_time, Voltage, type = "l", xlab = "datetime"))

with(data, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering"))
points(data$date_time, data$Sub_metering_2, type = "l", col = "red")
points(data$date_time, data$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright", legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

with(data, plot(date_time, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()

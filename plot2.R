#read-in data
library(data.table)
library(dplyr)

data <- data.table(read.delim("household_power_consumption.txt", header = T, sep = ";"))

head(data)

#create date time variable

data$date_time <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

#convert Date column from character to Date

data$Date <- as.Date.character(x = data$Date, format = "%d/%m/%Y")
str(data)

#create weekday variable

data$Weekday <- weekdays(data$Date)

#subset data based on weekday (Thurs, Fri, Sat)

data_weekdays <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

#save plot 2

png(file = "plot2.png", width = 480, height = 480)

with(data_weekdays, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (Kilowatts)",
                         xlab = ""))

dev.off()

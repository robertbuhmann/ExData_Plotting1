#install.packages("data.table")
library(data.table)
#install.packages("lubridate")
library(lubridate)
library(dplyr)

#read-in data

data <- data.table(read.delim("household_power_consumption.txt", header = T, sep = ";"))

#convert Date variable

data$Date <- as.Date.character(x = data$Date, format = "%d/%m/%Y")

head(data)
names(data)
str(data)

#subset data

data <- data %>% filter(Date =="2007-02-01" | Date == "2007-02-02")


#convert character variables to numeric

col.names <- names(data[, c(3:9)])

data <- data %>% mutate_at(c(col.names), as.numeric)

#save plot1

png( file = "plot1.png",
     width = 480, height = 480)

with(data, hist(Global_active_power, col = "red", xlim = c(0,6),
                         xlab = "Global Active Power (kilowatts)",
                         main = "Global Active Power"))

dev.off()

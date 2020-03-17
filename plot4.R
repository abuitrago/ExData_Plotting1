## Libraries
library(dplyr)
library(lubridate)

## Read data
consumption <- read.table("./Week1/household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character", na.strings = "?")
consumption <- tbl_df(consumption)

## Tidying data
names(consumption) <- as.vector(strsplit(names(consumption), "\\."))

consumption[,1] <- dmy(consumption$Date)
consumption <- filter(consumption, Date ==dmy("01/02/2007") | Date == dmy("02/02/2007"))
consumption[,3:9] <- sapply(consumption[,3:9],as.numeric)
consumption <- mutate(consumption, Date = paste(consumption$Date,consumption$Time))
consumption <- select(consumption, -Time)
consumption[,1] <- ymd_hms(consumption$Date)

## Graph
dev.new(width = 480, height = 480, unit = "px")
par(mfrow = c(2,2))
with(consumption,plot(Date, Global_active_power, type = "l", ylab = "Global Active Power"))
with(consumption,plot(Date, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(consumption,plot(Date, Sub_metering_1, type = "l", xlab ="", ylab = "Energy sub metering"))
points(consumption$Date, consumption$Sub_metering_2, type = "l", col = "orange")
points(consumption$Date, consumption$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = names(consumption[,6:8]), col= c("black", "orange", "blue"), lty=1, cex = 0.5, bty = "n", x.intersp = 0.5)
with(consumption,plot(Date, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.copy(png, file = "plot4.png")
dev.off()
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

## Graph
hist(cons$Global_active_power, col = "orange", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()
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
with(consumption,plot(Date, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()
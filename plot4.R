library(dplyr)
library(lubridate)

## Load file and modified the class of the Date column
tblroot <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
tblroot$Date <- dmy(tblroot$Date)


## Filter study dates and change the class of the data columns
tblwork <- tbl_df(tblroot)
rm(tblroot)
tblwork <- tblwork %>%
    filter (Date > "2007-01-31" & Date < "2007-02-03") %>%
    arrange (Date)

tblwork$Date <- ymd_hms(paste(tblwork$Date, tblwork$Time))
tblwork$Global_active_power <- as.numeric(tblwork$Global_active_power)
tblwork$Global_reactive_power <- as.numeric(tblwork$Global_reactive_power)
tblwork$Voltage <- as.numeric(tblwork$Voltage)
tblwork$Sub_metering_1 <- as.numeric(tblwork$Sub_metering_1)
tblwork$Sub_metering_2 <- as.numeric(tblwork$Sub_metering_2)

## Built plot4 and png generate
par (mfrow = c(2,2))

## Plot c(1,1)
plot(tblwork$Date, tblwork$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Plot c(1,2)
plot(tblwork$Date, tblwork$Voltage, type = "l", xlab = "datatime", ylab = "Voltage")

## Plot c(2,1)
plot(tblwork$Date, tblwork$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(tblwork$Date, tblwork$Sub_metering_2, type = "l", col = "red")
lines(tblwork$Date, tblwork$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty=1, col = c ("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.7)

## Plot c(2,2)
plot(tblwork$Date, tblwork$Global_reactive_power, type = "l", xlab = "datatime", ylab = "Global_reactive_power")

dev.copy(png, "plot4.png")
dev.off()

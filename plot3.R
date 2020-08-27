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
tblwork$Sub_metering_1 <- as.numeric(tblwork$Sub_metering_1)
tblwork$Sub_metering_2 <- as.numeric(tblwork$Sub_metering_2)

## Built plot3 and png generate
plot(tblwork$Date, tblwork$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(tblwork$Date, tblwork$Sub_metering_2, type = "l", col = "red")
lines(tblwork$Date, tblwork$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty=1, col = c ("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, "plot3.png")
dev.off()



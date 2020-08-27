library(dplyr)
library(lubridate)

## Load file and modified the class of the Date column
tblroot <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
tblroot$Date <- dmy(tblroot$Date)

## Filter study dates and change the class of Global_active_power column
tblwork <- tbl_df(tblroot)
rm(tblroot)
tblwork <- tblwork %>%
    filter (Date > "2007-01-31" & Date < "2007-02-03") %>%
    arrange (Date)

tblwork$Global_active_power <- as.numeric(tblwork$Global_active_power)

## Built plot1 and png generate
hist(tblwork$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, "plot1.png")
dev.off()



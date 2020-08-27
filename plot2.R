library(dplyr)
library(lubridate)

## Load file and modified the class of the Date column
tblroot <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
tblroot$Date <- dmy(tblroot$Date)


## Filter study dates and change the class of the Global_active_power column
tblwork <- tbl_df(tblroot)
rm(tblroot)
tblwork <- tblwork %>%
    filter (Date > "2007-01-31" & Date < "2007-02-03") %>%
    arrange (Date)

tblwork$Date <- ymd_hms(paste(tblwork$Date, tblwork$Time))
tblwork$Global_active_power <- as.numeric(tblwork$Global_active_power)

## Built plot2 and png generate
plot(tblwork$Date, tblwork$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, "plot2.png")
dev.off()





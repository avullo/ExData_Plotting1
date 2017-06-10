#!/usr/bin/env Rscript

## plot1.R

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destZipFile <- "household_power_consumption.zip"
destFile <- "household_power_consumption.txt"

if(!file.exists(destFile)){
  if(!file.exists(destZipFile)){
    download.file(fileUrl, destfile = destZipFile, method = "curl")    
    unzip(destZipFile) 
  }
  else{
    unzip(destZipFile)
  }
}

## read data from 2007-02-01 to 2007-02-02: 
## skip first 66637 and read the next 2880 lines
## these numbers have been derived by running from the shell:
## $ grep -n "^1/2/2007\|^2/2/2007" household_power_consumption.txt
fcon <- file("household_power_consumption.txt")
open(fcon)
data <- read.table(fcon, skip = 66637, nrows = 2880, sep = ";")
close(fcon)

# we've skiipped the header so we have to reassign col names
names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# prepare graph device, default to requested width/height (480x480)
png(filename = "plot1.png")
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()

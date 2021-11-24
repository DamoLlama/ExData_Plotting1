##R script to read data from UC Irvine Machine Learning Repository, and
##create png file with a line plot of Energy sub metering over time

##start up activities, load libraries,
##create directory paths and create if they don't exist
library(dplyr)
mainDir <- "C:/Users/damie/Documents/R/training/ExData_Plotting1"
dataDir <- "data"

if (!dir.exists("data")) {
        dir.create(file.path(mainDir, dataDir), showWarnings = FALSE)
}

##download data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "data/mydata.zip")
unzip("data/mydata.zip")
data <- read.table("household_power_consumption.txt", sep = ";")

##subset on date for two days and convert to date
wdata <- data[which(data$V1 %in% c("1/2/2007", "2/2/2007")),]
xdate <- paste(wdata$V1, wdata$V2, sep = " ")
datetime <- strptime(xdate, format = "%d/%m/%Y %H:%M:%S")
gdata <- wdata %>% mutate(V10 = datetime)

##create plot 3 png file
png("plot3.png", width = 480, height = 480)
with(gdata, plot(V10, V7, type = "l", ylab = "Energy sub metering", xlab = ""))
with(gdata, lines(V10, V8, type = "l", col = "red"))
with(gdata, lines(V10, V9, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

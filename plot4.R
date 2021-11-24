##R script to read data from UC Irvine Machine Learning Repository, and
##create png file with a 2 x 2 matrix of plots

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

##create plot 4 png file
png("plot4.png", width = 480, height = 480)
##set canvas for creating four plots
par(mfrow = c(2,2))
##plot1
plot(gdata$V10, gdata$V3, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
##plot2
plot(gdata$V10, gdata$V5, type = "l", ylab = "Voltage", xlab = "datetime")
##plot3
with(gdata, plot(V10, V7, type = "l", ylab = "Energy sub metering", xlab = ""))
with(gdata, lines(V10, V8, type = "l", col = "red"))
with(gdata, lines(V10, V9, type = "l", col = "blue"))
legend("topright", inset = 0.02, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), box.lty=0)
##plot4
plot(gdata$V10, gdata$V4, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()

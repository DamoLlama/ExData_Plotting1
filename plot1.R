##R script to read data from UC Irvine Machine Learning Repository, and
##create png file with a histogram of Global Active Power

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
gdata <- wdata %>% mutate(V10 = as.Date(V1, tryFormats = c("%d/%m/%Y"), optional = TRUE)) %>% select(V2:V10)

##create plot 1 png file
png("plot1.png", width = 480, height = 480)
hist(as.numeric(gdata$V3), col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

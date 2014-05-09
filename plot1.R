# Get data from the website and unzip it
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./data.zip")
unzip("data.zip")

# load data for dates between  2007-02-01 and 2007-02-02
require(sqldf)
data <- read.csv.sql("household_power_consumption.txt", sep=";",
                      "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'",
                      colClasses=c("Date", "character", "numeric", "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"))

# create png file
png(file="plot1.png")

# create a histogram
hist(data$Global_active_power,main="Global Active Power", xlab="Global Active Power (kilowatts)",
     col="red")

# copy plot to png file
dev.off()
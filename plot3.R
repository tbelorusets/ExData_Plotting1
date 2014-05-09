# Get data from the website and unzip it
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./data.zip")
unzip("data.zip")

# load data for dates between  2007-02-01 and 2007-02-02
require(sqldf)
data <-read.csv.sql("household_power_consumption.txt", sep=";",
                    "select * from file where Date = '1/2/2007' OR Date = '2/2/2007'",
                    colClasses=c("Date", "character", "numeric", "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

# create a column with date and time bound together
data$datetime <- strptime(paste(data$Date, data$Time), format='%d/%m/%Y %H:%M:%S')

# create png file
png(file="plot3.png")

# plot the line plots
plot(data$datetime,data$Sub_metering_1, type="n",ylab="Energy Sub Metering", xlab="" )
lines(data$datetime,data$Sub_metering_1, type="l", col="black")
lines(data$datetime,data$Sub_metering_2, type="l", col="red")
lines(data$datetime,data$Sub_metering_3, type="l", col="blue")
legend("topright", lty=c(1,1,1), col = c("black","red", "blue" ),  
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# copy plot to png file
dev.off()
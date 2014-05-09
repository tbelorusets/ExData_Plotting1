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

png(file="plot4.png")
# setup layout
par(mfcol=c(2,2))

# plot all plots
with (data, {
# plot the first plot
plot(data$datetime,data$Global_active_power, type="n",ylab="Global Active Power", xlab="" )
lines(data$datetime,data$Global_active_power, type="l")

# plot the second plot
plot(data$datetime,data$Sub_metering_1, type="n",ylab="Energy sub metering", xlab="" )
lines(data$datetime,data$Sub_metering_1, type="l", col="black")
lines(data$datetime,data$Sub_metering_2, type="l", col="red")
lines(data$datetime,data$Sub_metering_3, type="l", col="blue")
legend("topright", lty=c(1,1,1), col = c("black","red", "blue" ),bty = "n", cex=0.9, 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot the third plot
plot(data$datetime,data$Voltage, type="n",ylab="Voltage", xlab="" )
lines(data$datetime,data$Voltage, type="l")

# plot the fourth plot
plot(data$datetime,data$Global_reactive_power, type="n",ylab="Global_reactive_power", xlab="" )
lines(data$datetime,data$Global_reactive_power, type="l")
})


# copy plot to png file
dev.off()
## Reading full dataset
data_full <- read.csv(".household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Saving to file
png("plot4.png", width = 480, height = 480)

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Datetime, Global_active_power, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Datetime, Voltage, type="l", 
       ylab="Voltage", xlab="datetime")
  plot(Datetime, Sub_metering_1, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Datetime, Sub_metering_2,col='Red')
  lines(Datetime, Sub_metering_3,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=c(1,1), lwd=c(1,1), 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Datetime, Global_reactive_power, type="l", 
       ylab="Global Rective Power",xlab="datetime")
})
dev.off()
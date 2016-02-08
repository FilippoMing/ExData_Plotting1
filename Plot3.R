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
png("plot3.png", width = 480, height = 480)

## Plot 3
with(data, {
  plot(Datetime, Sub_metering_1, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Datetime, Sub_metering_2,col='Red')
  lines(Datetime, Sub_metering_3,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=c(1,1), lwd=c(1,1), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
filename <- "ExData_Dataset.zip"

## download file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, filename, mode="wb")

unzip(filename)

## read data and save as exData
exData <- read.table("./household_power_consumption.txt", sep=";", header=T, na.strings="?")

## change date to date type
exData$Date <- as.Date(exData$Date, "%d/%m/%Y")

## subset for data between 2007-02-01 and 2007-02-02
exData <- subset(exData,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))


## combine data and time into one column
dateCol <- strptime(paste(exData$Date, exData$Time, sep=" "),  "%Y-%m-%d %H:%M:%S")
dateCol <- setNames(dateCol , "DateTime")

##bind column
exData2 <- cbind(dateCol, exData)

## set  variables
globalActivePower <- as.numeric(exData2$Global_active_power)
globalReactivePower <- as.numeric(exData2$Global_reactive_power)
voltage <- as.numeric(exData2$Voltage)

subMeter1 <- as.numeric(exData2$Sub_metering_1)
subMeter2 <- as.numeric(exData2$Sub_metering_2)
subMeter3 <- as.numeric(exData2$Sub_metering_3)

exData2 <- cbind(exData2,globalActivePower )
exData2 <- cbind(exData2,globalReactivePower )
exData2 <- cbind(exData2,voltage )
exData2 <- cbind(exData2,subMeter1 )
exData2 <- cbind(exData2,subMeter2 )
exData2 <- cbind(exData2,subMeter3 )

##create plot
par(mfrow = c(2,2))
plot(exData2$dateCol, exData2$globalActivePower, type="l", xlab="", ylab="Global Active Power" )

plot(exData2$dateCol, exData2$voltage, type="l",  xlab="datetime", ylab="Voltage")

plot(exData2$dateCol, exData2$subMeter1, type="l", ylab="Energy Submetering", xlab="")
lines(exData2$dateCol, exData2$subMeter2, type="l", col="red")
lines(exData2$dateCol, exData2$subMeter3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="n")

plot(exData2$dateCol, exData2$globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

## create png file
dev.copy(png, "plot4.png",width = 480, height = 480)
dev.off()


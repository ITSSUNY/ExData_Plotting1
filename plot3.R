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
subMeter1 <- as.numeric(exData2$Sub_metering_1)
subMeter2 <- as.numeric(exData2$Sub_metering_2)
subMeter3 <- as.numeric(exData2$Sub_metering_3)

exData2 <- cbind(exData2,subMeter1 )
exData2 <- cbind(exData2,subMeter2 )
exData2 <- cbind(exData2,subMeter3 )

##create plot
plot(exData2$dateCol, exData2$subMeter1, type="l", ylab="Energy Submetering", xlab="")
lines(exData2$dateCol, exData2$subMeter2, type="l", col="red")
lines(exData2$dateCol, exData2$subMeter3, type="l", col="blue")

## create png file
dev.copy(png, "plot3.png",width = 480, height = 480)
dev.off()



# get the source file, download as electric.zip
if (!file.exists("electric.zip")){
       fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
       download.file(fileURL, "electric.zip", method="curl")
}

#unzip into electric dataset
if (!file.exists("household_power_consumption.txt")) { 
  unzip("electric.zip") 
}

#read into data frame power_all, and subset for day of interest, 2/1/07
power_all <- read.csv("household_power_consumption.txt", sep = ";")
power1 <- subset(power_all, power_all$Date == "2/1/2007")
power2 <- subset(power_all, power_all$Date == "2/2/2007")
power1 <- rbind(power1, power2)

#create new variable of newtime
power1$newtime <- paste(power1$Date, power1$Time)
power1$newtime <- strptime(power1$newtime, format ="%m/%d/%Y %H:%M:%S")

#create 4 line graphs in a 2x2 grid as Plot4.png
png(filename = "Plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

#upper left graph global active power, per plot2
plot(power1$Global_active_power, type = "l", ylab = "Global Active Power", ylim = c(0,6), xaxt = "n", xlab = "")
axis(1,at=c(0,1440,2880),labels=c("Thurs", "Fri", "Sat"))

#upper right voltage graph
plot(power1$Voltage, type = "l", ylab = "Voltage", ylim = c(230, 250), xaxt = "n", xlab = "date-time")
axis(1,at=c(0,1440,2880),labels=c("Thurs", "Fri", "Sat"))

#lower left per plot3
plot(power1$Sub_metering_1, type = "l", ylab = "Energy sub-metering", ylim = c(0,30), xaxt = "n", xlab = "")
lines(power1$Sub_metering_2, type = "l", col = "red")
lines(power1$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, cex = 0.5)
axis(1,at=c(0,1440,2880),labels=c("Thurs", "Fri", "Sat"))

#lower right global reactive power line graph
plot(power1$Global_reactive_power, type = "l", ylab = "Voltage", ylim = c(0, 1), xaxt = "n", xlab = "date-time")
axis(1,at=c(0,1440,2880),labels=c("Thurs", "Fri", "Sat"))

dev.off()




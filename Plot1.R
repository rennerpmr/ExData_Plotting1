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

#create histogram of Global Active Power as Plot1.png
png(filename = "Plot1.png", width = 480, height = 480, units = "px")
hist(power1$Global_active_power, col = "red", main="Global Active Power", ylim = c(0,1200), xlim = c(0,6), xlab = "Global Active Power (killowats)")
dev.off()




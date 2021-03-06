power <- read.table("data/household_power_consumption.txt", sep = ";",
                    na.strings = "?", nrows = 2881, skip = 66637)
colnames(power) <- c("Date", "Time", "Global_active_power", 
                     "Global_reactive_power", "Voltage", "Global_intensity",
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
x <- paste(power$Date, power$Time)
DTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
power <- cbind(DTime, power[,3:9])
with(power, plot(DTime, Global_active_power, type = "l", xlab = "",
                 ylab = "Global Active Power (kilowatts)", xaxs = 'r'))
dev.copy(png, file = "plot2.png")
dev.off()
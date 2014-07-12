power <- read.table("data/household_power_consumption.txt", sep = ";",
                    na.strings = "?", nrows = 2881, skip = 66637)
colnames(power) <- c("Date", "Time", "Global_active_power", 
                     "Global_reactive_power", "Voltage", "Global_intensity",
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
x <- paste(power$Date, power$Time)
DTime <- strptime(x, "%d/%m/%Y %H:%M:%S")
power <- cbind(DTime, power[,3:9])
par(mfrow = c(2,2), mar = c(4.1, 4.1, 1.1, 1.1), cex = .6)
with(power, {
       plot(DTime, Global_active_power, type = "l", xlab = "",
            ylab = "Global Active Power", xaxs = "r")
       plot(DTime, Voltage, type = "l", xlab = "",
            ylab = "Voltage", xaxs = "r")
       plot(DTime, Sub_metering_1, type = "l", xlab = "",
            ylab = "Energy sub metering", xaxs = "r")
})
lines(power$DTime, power$Sub_metering_2, col = "red")
lines(power$DTime, power$Sub_metering_3, col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd = 1, col = c("black", "red", "blue"), box.lwd = 0)
with(power, plot(DTime, Global_reactive_power, type = "l", xlab = "",
                 ylab = "Global Reactive Power", xaxs = "r"))
dev.copy(png, file = "plot4.png")
dev.off()
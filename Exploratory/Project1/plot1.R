power <- read.table("data/household_power_consumption.txt", sep = ";"
                    na.strings = "?", nrows = 2880, skip = 66637)
colnames(power) <- c("Date", "Time", "Global_active_power", 
                     "Global_reactive_power", "Voltage", "Global_intensity"
                     "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
hist(elec$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
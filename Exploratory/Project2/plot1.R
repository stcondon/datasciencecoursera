NEI <- readRDS("data//exdata_data_NEI_data/summarySCC_PM25.rds")
total <- tapply(NEI$Emissions, NEI$year, FUN = sum)
year <- seq(1999,2008,3)
total <- total/1000000
total <- cbind(year, total)
plot(total, type = "l", main = "Total US Emissions", xlab = "Year", 
     xaxt = "n", ylab = "PM2.5 Emitted (million tons)")
axis(1, year)
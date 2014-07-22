NEI <- readRDS("data//exdata_data_NEI_data/summarySCC_PM25.rds")
charm_city <- NEI[NEI$fips == "06037", c(4,6)]
charm_city <- tapply(charm_city$Emissions, charm_city$year, FUN = sum)
charm_city <- charm_city/1000
year <- seq(1999,2008,3)
charm_city <- cbind(year,charm_city)
plot(charm_city, type = "l", main = "Baltimore Emissions",
     xlab = "Year", xaxt = "n", ylab = "PM2.5 Emitted (thousand tons)")
axis(1, year)
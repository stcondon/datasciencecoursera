library(plyr)
library(ggplot2)
NEI <- readRDS("data//exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data//exdata_data_NEI_data/Source_Classification_Code.rds")
mv_list <- SCC[grep("Mobile", SCC$EI.Sector),1]
mv <- NEI[NEI$SCC %in% mv_list,c(1,4,6)]
mv <- rbind(mv[mv$fips == "24510",], mv[mv$fips == "06037",])
mv <- ddply(mv, .(fips, year), colwise(sum))
mv <- cbind(c(rep("LA",4), rep("Baltimore",4)), mv[,c(2,3)])
colnames(mv) <- c("City", "Year", "Emissions")
png(file = "plot6.png", width = 600)
qplot(Year, Emissions, data = mv, main = "Orioles vs Angels", geom = "line",
      ylab = "PM2.5 Emissions (tons)", color = City)
dev.off()
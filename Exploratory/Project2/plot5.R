library(plyr)
NEI <- readRDS("data//exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data//exdata_data_NEI_data/Source_Classification_Code.rds")
mv_list <- SCC[grep("Mobile", SCC$EI.Sector),1]
mv <- NEI[NEI$SCC %in% mv_list,c(1,4,6)]
mv <- mv[mv$fips == "24510", c(2,3)]
mv <- ddply(mv, .(year), colwise(sum))
png(file = "plot4.png", width = 550)
plot(mv, type = "l", main = "Charm City Motor Vehicle Emissions",
     ylab = "PM2.5 Emissions (tons)")
dev.off()
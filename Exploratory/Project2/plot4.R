library(plyr)
NEI <- readRDS("data//exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("data//exdata_data_NEI_data/Source_Classification_Code.rds")
coal_list <- SCC[grep("Coal", SCC$EI.Sector),1]
coal <- NEI[NEI$SCC %in% coal_list,c(4,6)]
coal <- ddply(coal, .(year), colwise(sum))
png(file = "plot4.png")
plot(coal, type = "l", main = "Countrywide Coal Emissions", 
     ylab = "PM2.5 Emissions (tons)")
dev.off()
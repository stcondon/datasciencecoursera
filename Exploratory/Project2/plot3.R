library(ggplot2)
library(plyr)
NEI <- readRDS("data//exdata_data_NEI_data/summarySCC_PM25.rds")
charm_city <- NEI[NEI$fips == "24510", c(4,5,6)]
charm_city <- ddply(charm_city, .(year, type), colwise(sum))
png(file = "plot3.png", width = 600)
qplot(year, Emissions, data = charm_city, geom = "line", facets = . ~ type)
dev.off()
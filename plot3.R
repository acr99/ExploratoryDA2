# Plot 3

library("plyr")
library("ggplot2")

# read data
nei <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")

# aggregate data by year, type and fip
EmissionsReduced <- ddply(nei, .(year, fips, type), function(x) colSums(x[4]))

# make plot
png(filename = "Plot3.png", width = 800, height = 600, units = "px")
qplot(year, Emissions, data = subset(EmissionsReduced, fips == "24510"), facets = .~type, color = type, geom = "line")+ ggtitle("Total PM2.5 Emissions by Source, Type and Year in Baltimore")
dev.off()


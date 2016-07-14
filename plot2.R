# Plot 2

# read data
nei <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")

# aggregate data by year and fip code
EmissionsByFip <- aggregate(nei$Emissions, by = (list(Year = nei$year, Fip = nei$fips)), FUN = sum)

# make plot
png(filename = "Plot2.png", width = 800, height = 600, units = "px")
with(subset(EmissionsByFip, Fip == "24510"), plot(Year, x, type = "n", xlab = "Year", ylab = "Total PM2.5", xaxt = "n"))
axis(1, at = as.character(EmissionsByFip$Year))
with(subset(EmissionsByFip, Fip == "24510"), points(Year, x, pch = 19))
with(subset(EmissionsByFip, Fip == "24510"), abline(lm(x ~ Year)), lwd = 2)
title(main = "Total PM2.5 Emissions by Year in Baltimore")
dev.off()



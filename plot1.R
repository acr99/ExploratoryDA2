# Plot 1

# read data
nei <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")

# aggregate data by year
EmissionsByYear <- aggregate(nei$Emissions, by = (list(Year = nei$year)), FUN = sum)

# make plot
png(filename = "Plot1.png", width = 800, height = 600, units = "px")
plot(EmissionsByYear$Year, EmissionsByYear$x, type = "n", xlab = "Year", ylab = "Total PM2.5 (tons)", xaxt = "n")
axis(1, at = as.character(EmissionsByYear$Year) )
with(EmissionsByYear, points(Year, x, pch = 19))
with(EmissionsByYear, abline(lm(x ~ Year)), lwd = 2)
title(main = "Total PM2.5 Emissions by Year in the U.S.")
dev.off()



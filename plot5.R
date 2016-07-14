# Plot 5
library("plyr")
library("ggplot2")

# read data
nei <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
scc <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

# merge nei and scc data 
scc_short <- data.frame(SCC = scc$SCC, Short.Name = scc$Short.Name, Level2 = scc$SCC.Level.Two)
data_merged <- merge(nei, scc_short, by = "SCC")

# substract just the data related to coal sources
nei_vehicle <- data_merged[grep("[V,v]ehicle",data_merged$Level2),]


# aggregate data by year
EmissionVehiclesBaltimore <- subset(nei_vehicle, fips == "24510")
AggEmissionVehiclesBaltimore <- aggregate(EmissionVehiclesBaltimore$Emissions, by = (list(Year = EmissionVehiclesBaltimore$year)), FUN = sum)

# make plot
png(filename = "Plot5.png", width = 800, height = 600, units = "px")

ggplot(data = subset(AggEmissionVehiclesBaltimore), aes(Year, x)) + 
      geom_point(size = 5) + 
      geom_smooth(stat = "smooth", method = "auto") +
      labs(title = "Emissions from Motor-vehicle Sources in Baltimore", y = "Emissions ")      

dev.off()
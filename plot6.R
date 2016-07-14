# Plot 6
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
EmissionVehiclesSelect <- subset(nei_vehicle, fips %in% c("24510","06037"))
AggEmissionVehiclesSelect <- aggregate(EmissionVehiclesSelect$Emissions, by = (list(Year = EmissionVehiclesSelect$year, Fips = EmissionVehiclesSelect$fips)), FUN = sum)
AggEmissionVehiclesSelect$Fips[AggEmissionVehiclesSelect$Fips=="06037"]<-"Los Angeles"
AggEmissionVehiclesSelect$Fips[AggEmissionVehiclesSelect$Fips=="24510"]<-"Baltimore"

# make plot
png(filename = "Plot6.png", width = 800, height = 600, units = "px")
qplot(AggEmissionVehiclesSelect$Year, AggEmissionVehiclesSelect$x, geom ="line", colour = AggEmissionVehiclesSelect$Fips)+
      labs(title = "Emissions from Motor-vehicle Sources in Los Angeles and Baltimore", y = "Total PM2.5 Coal-combustion Emissions", x = "Year")
dev.off()


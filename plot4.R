# Plot 4
library("plyr")
library("ggplot2")

# read data
nei <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds")
scc <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds")

# merge nei and scc data 
scc_short <- data.frame(SCC = scc$SCC, Short.Name = scc$Short.Name)
data_merged <- merge(nei, scc_short, by = "SCC")

# substract just the data related to coal sources
nei_coal <- data_merged[grep("[C,c]oal",data_merged$Short.Name),]

# aggregate data by year
EmissionsByYear <- aggregate(nei_coal$Emissions, by = (list(Year = nei_coal$year)), FUN = sum)

# make plot
png(filename = "Plot4.png", width = 800, height = 600, units = "px")
ggplot(data = subset(EmissionsByYear), aes(Year, x)) + 
      geom_point(size = 5) + 
      geom_smooth() +
      labs(title = "Total emissions from coal combustion-related sources in the U.S.", y = "Total PM2.5 Coal-combustion Emissions")
dev.off()




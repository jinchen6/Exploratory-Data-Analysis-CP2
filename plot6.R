# plot6.R

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
# Los Angeles County has seen the greatest changes over time in motor vehicle emissions.

library(dplyr)
library(ggplot2)

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# Get emissions data from motor vehicle sources in Baltimore City $ Los Angeles County, California (fips == "06037").
mvbl <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
a <- aggregate(Emissions ~ year + fips, mvbl, sum)
a$fips[a$fips == "24510"] <- "Baltimore, MD"
a$fips[a$fips == "06037"] <- "Los Angeles, CA"
colnames(a)[2] <- "City"

png("plot6.png", width=720, height=480)
g <- ggplot(a, aes(x=factor(year), y=Emissions, fill=City)) +
  geom_bar(stat="identity") +
  facet_grid(.~City) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission")) + 
  labs(title=expression("Total Emissions from motor vehicle sources in Baltimore City, MD vs Los Angeles, CA"))
print(g)
dev.off()

# plot5.R
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Emissions from coal combustion related sources have decreased from 1999–2008.

require(dplyr)
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# retrieve all records from motor vehicle sources (type=="ON-ROAD") from 1999–2008 in Baltimore City (fips=="24510").
mv <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
a <- aggregate(Emissions ~ year, mv, sum)

png("plot5.png",width=480,height=480,units="px",bg="transparent")
barplot(
  (a$Emissions)/1000,
  names.arg=a$year,
  xlab="Year",
  ylab="PM2.5 Emissions",
  main="Total PM2.5 emission from motor vehicle sources in Baltimore.",
  col = "blue"
)
dev.off()

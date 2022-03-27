# plot4.R
# 4. Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?
# Yes. Emissions from coal combustion related sources have decreased from 1999–2008.
if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# merge NEI & SCC by SCC digit strings
m <- merge(NEI, SCC, by="SCC")

# retrieve all records with Short.Name Coal
coal <- grepl("coal", m$Short.Name, ignore.case=TRUE)
c <- m[coal, ]

# get emissions from coal combustion-related sources from 1999–2008
a <- aggregate(Emissions ~ year, c, sum)

png("plot4.png",width=480,height=480,units="px",bg="transparent")
barplot(
  (a$Emissions)/1000,
  names.arg=a$year,
  xlab="Year",
  ylab="PM2.5 Emissions",
  main="Total PM2.5 emission from coal combustion-related sources",
  col = "blue"
)
dev.off()

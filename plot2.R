# plot2.R

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}
# Aggregate by sum of the total emissions by year

bNEI <- NEI[NEI$fips=="24510",]
aTotalb <- aggregate(Emissions ~ year,bNEI, sum)

png("plot2.png",width=480,height=480,units="px",bg="transparent")
barplot(
  (aTotalb$Emissions)/1000,
  names.arg=aTotalb$year,
  xlab="Year",
  ylab="PM2.5 Emissions",
  main="Total PM2.5 emission Baltimore",
  col = "blue"
)
dev.off()

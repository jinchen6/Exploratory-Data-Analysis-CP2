# plot1.R

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

# As we can see from the plot, total emissions have decreased in the US from 1999 to 2008.


if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# Aggregate by sum of the total emissions by year
aTotal <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png",width=480,height=480,units="px",bg="transparent")
barplot(
  (aTotal$Emissions)/1000,
  names.arg=aTotal$year,
  xlab="Year",
  ylab="PM2.5 Emissions",
  main="Total PM2.5 emission from all sources",
  col = "blue"
)
dev.off()

# plot3.R

# Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
# 
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# The non-road, nonpoint, on-road source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.
# Which have seen increases in emissions from 1999–2008?
# The point source saw a slight increase overall from 1999-2008. Also note that the point source saw a 
# significant increase until 2005 at which point it decreases again by 2008 to just above the starting values.

library(dplyr)
library(ggplot2)

if(!exists("NEI")){
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

bNEI <- NEI[NEI$fips=="24510",]
bNEIyearType <- bNEI %>% group_by(year,type) %>% summarise(Emissions=sum(Emissions))

png("plot3.png",width=480,height=480,units="px",bg="transparent")

g <- ggplot(data = bNEIyearType, aes(x = factor(year), y = Emissions, fill = type, colore = "black")) +
 geom_bar(stat = "identity") + facet_grid(. ~ type) + 
 xlab("Year") + ylab(expression('PM'[2.5]*' Emission')) +
 ggtitle("Baltimore Emissions by Source Type from 1999–2008")
print(g)

dev.off()

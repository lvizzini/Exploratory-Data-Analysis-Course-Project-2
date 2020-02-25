## read file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##create p object with total Emission by year and type for Baltimore
library(data.table)
library(ggplot2)
NEI<-as.data.table(NEI)
Balt<-NEI[fips=="24510"] 

p<-Balt[,.(Emissions=sum(Emissions)),by=.(year,type)]

##ggplot to answer the question: <which of these type sources have seen decreases in emissions from 1999–2008 for Baltimore?> 
png('plot3.png')
g <- ggplot(p, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore from 1999 to 2008')
print(g)
dev.off()
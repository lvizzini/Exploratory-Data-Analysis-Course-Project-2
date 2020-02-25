## read file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(data.table)
library(ggplot2)
##merge information of SCC to NEI
NEI_SCC <- merge(NEI, SCC, by="SCC")
NEI_SCC<-as.data.table(NEI_SCC)

#select data from Baltimore or Los Angeles and type vehicle
s<-NEI_SCC[(fips=="24510"| fips=="06037") & type=="ON-ROAD"] 
##create p object with total Emission by year for motor vehicle
p<-s[,.(Emissions=sum(Emissions)),by=.(year,fips)]

##ggplot to answer the question: <Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County> 
png('plot6.png')
g <- ggplot(p, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Los Angeles (fips = "06037") vs Baltimore City (fips = "24510") 1999-2008')
print(g)
dev.off()
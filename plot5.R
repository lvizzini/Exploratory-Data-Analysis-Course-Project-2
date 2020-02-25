## read file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


library(data.table)
library(ggplot2)
##merge information of SCC to NEI
NEI_SCC <- merge(NEI, SCC, by="SCC")
NEI_SCC<-as.data.table(NEI_SCC)

#select data from Baltimore and type vehicle
Balt<-NEI_SCC[fips=="24510" & type=="ON-ROAD"] 
##create p object with total Emission by year for motor vehicle
p<-Balt[,.(Emissions=sum(Emissions)),by=year]

##ggplot to answer the question: <How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City> 
png('plot5.png')
g <- ggplot(p, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from from motor vehicle from 1999 to 2008 in Baltimore')
print(g)
dev.off()
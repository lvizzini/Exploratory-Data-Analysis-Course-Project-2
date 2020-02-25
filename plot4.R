## read file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##create p object with total Emission by year for coal
library(data.table)
library(ggplot2)
##merge information of SCC to NEI
NEI_SCC <- merge(NEI, SCC, by="SCC")
NEI_SCC<-as.data.table(NEI_SCC)
##select coal index
coal<- grepl("coal", NEI_SCC$Short.Name, ignore.case=TRUE)
NEI_SCC_coal <- NEI_SCC[coal, ]
p<-NEI_SCC_coal[,.(Emissions=sum(Emissions)),by=year]

##ggplot to answer the question: <Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?> 
png('plot4.png')
g <- ggplot(p, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal from 1999 to 2008')
print(g)
dev.off()
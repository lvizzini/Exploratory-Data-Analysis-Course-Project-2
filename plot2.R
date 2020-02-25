## read file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##create p object with total Emission by year for Baltimore
library(data.table)
NEI<-as.data.table(NEI)
Balt<-NEI[fips=="24510"] 

p<-Balt[,.(Emissions=sum(Emissions)),by=year]

##barplot to answer the question: <Have total emissions from PM2.5 decreased in the United States from 1999 to 2008 for Baltimore?> Yes
png('plot2.png')
barplot(height=p$Emissions, names.arg=p$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Baltimore Total PM'[2.5]*' emissions'))
dev.off()
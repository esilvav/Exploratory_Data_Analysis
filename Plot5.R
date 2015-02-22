# Exploratory Data Analysis.
# Course Project 2
# PREGUNTA 5:
# How have emissions from motor vehicle sources changed from 1999 - 2008 in Baltimore City?

library(plyr)
library(ggplot2)

unzip("D:/censo 2010/data/exdata-data-NEI_data.zip", overwrite = T)

NEI <- readRDS("D:/censo 2010/data/summarySCC_PM25.rds")
head(NEI)
SCC <- readRDS("D:/censo 2010/data/Source_Classification_Code.rds")
head(SCC, n = 5)

## Carga de datos
sourced <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))

sourcec <- SCC[SCC$EI.Sector %in% sourced, ]["SCC"]

#Emisiones de los motores de los vehiculos
emissions <- NEI[NEI$SCC %in% sourcec$SCC & NEI$fips == "24510",]

#Emisiones de los vehiculos de baltimore cada año
balmv.pm25year <- ddply(emissions, .(year), function(x) sum(x$Emissions))
colnames(balmv.pm25year)[2] <- "Emissions"

#Grafica
png("D:/censo 2010/data/Plot5.png")
qplot(year, Emissions, data=balmv.pm25year, geom="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

#Impresion en Pantalla
qplot(year, Emissions, data=balmv.pm25year, geom="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

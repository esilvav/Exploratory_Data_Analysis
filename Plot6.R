# Exploratory Data Analysis.
# Course Project 2
# PREGUNTA 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California, California 
# (fips == "06037"). Which city has seen greater changes over time in motor 
# vehicle emissions?

library(plyr)
library(ggplot2)

unzip("D:/censo 2010/data/exdata-data-NEI_data.zip", overwrite = T)

NEI <- readRDS("D:/censo 2010/data/summarySCC_PM25.rds")
head(NEI)
SCC <- readRDS("D:/censo 2010/data/Source_Classification_Code.rds")
head(SCC, n = 5)

#Vehiculos estructuracion
mv.sourced <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))

mv.sourcec <- SCC[SCC$EI.Sector %in% mv.sourced, ]["SCC"]


#Datos de Baltimore City
emMV.ba <- NEI[NEI$SCC %in% mv.sourcec$SCC & NEI$fips == "24510", ]
#Datos de Angeles City
emMV.LA <- NEI[NEI$SCC %in% mv.sourcec$SCC & NEI$fips == "06037", ]

emMV.comb <- rbind(emMV.ba, emMV.LA)
  
#Emisiones de los vehiculos de la ciudades de Baltimore y los Angeles

tmveYR.county <- aggregate (Emissions ~ fips * year, data =emMV.comb, FUN = sum ) 
tmveYR.county$county <- ifelse(tmveYR.county$fips == "06037", "Los Angeles", "Baltimore")

#Grafica
png("D:/censo 2010/data/Plot6.png")
qplot(year, Emissions, data=tmveYR.county, geom="line", color=county) + ggtitle(expression("Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  from 1999 to 2008 in Los Angeles County, CA and Baltimore, MD")) + xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions"))
dev.off()

Impresion de pantalla
qplot(year, Emissions, data=tmveYR.county, geom="line", color=county) + ggtitle(expression("Motor Vehicle Emission Levels" ~ PM[2.5] ~ "  from 1999 to 2008 in Los Angeles County, CA and Baltimore, MD")) + xlab("Year") + ylab(expression("Levels of" ~ PM[2.5] ~ " Emissions"))

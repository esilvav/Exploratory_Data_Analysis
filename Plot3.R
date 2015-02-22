# Exploratory Data Analysis.
# Course Project 2
# PREGUNTA 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
#variable, which of these four sources have seen decreases in emissions from 1999 to 2008
#for Baltimore City? Which have seen increases in emissions from 1999 to 2008? Use the 
#ggplot2 plotting system to make a plot to answer this question.

library(plyr)
library(ggplot2)

unzip("D:/censo 2010/data/exdata-data-NEI_data.zip", overwrite = T)

NEI <- readRDS("D:/censo 2010/data/summarySCC_PM25.rds")
head(NEI)
SCC <- readRDS("D:/censo 2010/data/Source_Classification_Code.rds")
head(SCC, n = 5)

baltimore.city <- subset (NEI, fips == "24510")
typePM25.year <- ddply(baltimore.city, .(year, type), function(x) sum(x$Emissions))

#Cambio de Emisiones
colnames(typePM25.year)[3] <- "Emissions"

#Prepraracion para la graficacion
png("D:/censo 2010/data/Plot3.png")
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by source, type and year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)"))
dev.off()    

#Dibujo en pantalla
qplot(year, Emissions, data=typePM25.year, color=type, geom ="line") + ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emmission by source, type and year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (in tons)")) 

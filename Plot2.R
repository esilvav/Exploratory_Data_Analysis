# Exploratory Data Analysis.
# Course Project 2
# PREGUNTA 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library(plyr)
library(ggplot2)

unzip("D:/censo 2010/data/exdata-data-NEI_data.zip", overwrite = T)

NEI <- readRDS("D:/censo 2010/data/summarySCC_PM25.rds")
head(NEI)
SCC <- readRDS("D:/censo 2010/data/Source_Classification_Code.rds")
head(SCC, n = 5)

baltimore.city <- subset (NEI, fips == "24510")
total.PM25year <- tapply(baltimore.city$Emissions, baltimore.city$year, sum)

Prepraracion para la graficacion
png("D:/censo 2010/data/Plot2.png")
plot(names(total.PM25year), total.PM25year, type = "l", xlab="Year", ylab= expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), col = "blue")
dev.off()     

Dibujo en pantall
plot(names(total.PM25year), total.PM25year, type = "l", xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), main=expression("Total for Baltimore City" ~ PM[2.5] ~ "Emissions by Year"), col="blue")

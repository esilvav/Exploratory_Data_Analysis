# Exploratory Data Analysis.
# Course Project 2
# PREGUNTA 1:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

library(plyr)
library(ggplot2)

unzip("D:/censo 2010/data/exdata-data-NEI_data.zip", overwrite = T)

NEI <- readRDS("D:/censo 2010/data/summarySCC_PM25.rds")
head(NEI)
SCC <- readRDS("D:/censo 2010/data/Source_Classification_Code.rds")
head(SCC, n = 5)
years <- c("1999", "2002", "2005", "2008")
means <- vector()
for (i in years) {
    means[i] <- mean(NEI$Emissions[which(NEI$year == i)], na.rm = TRUE)
}
png(filename='D:/censo 2010/data/Plot1.png')
barplot(means, col = rainbow(20, start = 0, end = 1), main = "Mean PM_2.5 emissions (Tons)")

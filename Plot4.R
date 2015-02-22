# Exploratory Data Analysis.
# Course Project 2
# PREGUNTA 4:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999 to 2008?

library(plyr)
library(ggplot2)

unzip("D:/censo 2010/data/exdata-data-NEI_data.zip", overwrite = T)

NEI <- readRDS("D:/censo 2010/data/summarySCC_PM25.rds")
head(NEI)
SCC <- readRDS("D:/censo 2010/data/Source_Classification_Code.rds")
head(SCC, n = 5)

#Subconjunto nuestros datos por sólo carbón de combustión
coalcomb.scc <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Instutional - Coal", 
  "Fuel Comb - Electric Generation - Coal", "Fuel Comb - Industrial Boilers, ICEs - 
  Coal"))

coalcomb.scc1 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))

nrow(coalcomb.scc) #evaluate: rows 0

nrow(coalcomb.scc1) #evaluate: rows 91

#Grafica de las diferencias
dif1 <- setdiff(coalcomb.scc$SCC, coalcomb.scc1$SCC)
dif2 <- setdiff(coalcomb.scc1$SCC, coalcomb.scc$SCC)

length(dif1)#0

length(dif2)#91

coalcomb.codes <- union(coalcomb.scc$SCC, coalcomb.scc1$SCC)
length(coalcomb.codes) #91

# Estrutura del nuevo conjunto
coal.comb <- subset(NEI, SCC %in% coalcomb.codes)

coalcomb.pm25year <- ddply(coal.comb, .(year, type), function(x) sum(x$Emissions))

#cambio de columnas
colnames(coalcomb.pm25year)[3] <- "Emissions"

#Grafica de la funcion
png("D:/censo 2010/data/Plot4.png")
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()

#Captura en la patalla
qplot(year, Emissions, data=coalcomb.pm25year, color=type, geom="line") + stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", color = "purple", aes(shape="total"), geom="line") + geom_line(aes(size="total", shape = NA)) + ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) + xlab("Year") + ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

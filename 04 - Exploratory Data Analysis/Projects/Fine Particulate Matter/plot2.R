# plot.2.R

# load data:
NEI <- data.table::as.data.table(readRDS("./data/summarySCC_PM25.rds"))

# generate table by summing over years:
total_Emissions = subset(NEI,fips == "24510")
total_Emissions = total_Emissions[, lapply(.SD,sum,na.rm=TRUE),.SDcols=c("Emissions"),by=c("year")]

# plot result in barplot: 
png("plot2.png", width=480, height=480)
options(scipen=10)
barplot(total_Emissions[[2]], names = total_Emissions[[1]], xlab = "Years", 
        ylab = "Emissions (Tons)",
        main = "Emissions for each Year in Baltimore City")
dev.off()


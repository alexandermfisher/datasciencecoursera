# plot1.R

# load data (summarySCC_PM25.rds data file stored in "data" directory):
NEI <- data.table::as.data.table(readRDS("./data/summarySCC_PM25.rds"))

# sum over years to calculate total emissions over year:
total_Emissions <- NEI[, lapply(.SD,sum,na.rm=TRUE),.SDcols = c("Emissions"), by = "year"]

# plot result in barplot:
png("plot1.png", width=480, height=480)
options(scipen=10)
barplot(height = total_Emissions[[2]], names.arg = total_Emissions[[1]], 
        xlab = "Years", 
        ylab = "Emissions (Tons)",
        main = "Emissions for each Year")
dev.off()




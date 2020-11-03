# plot5.R

# load data:
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# find vehicle related obs this includes on road and off road vehicles.
vehicle_related <- grepl("Vehicle", SCC$SCC.Level.Two)
vehicle_SCC <- SCC[vehicle_related,"SCC"]
vehicle_NEI <- NEI[NEI$SCC %in% vehicle_SCC,]
balitmore_vehicle_NEI = subset(vehicle_NEI,fips == "24510")

# plot:
png("plot5.png", width=1000, height=1000)
options(scipen=10)
plot <- ggplot(balitmore_vehicle_NEI, aes(x = factor(year), y = Emissions)) +
        geom_bar(aes(fill = factor(year)),stat="identity") + guides(fill=FALSE) +
        scale_fill_brewer(palette="Set1") +
        labs(x="Year",y="Emissions (Tons)",title="Emissions from Motor Vehicles in Baltimore") +
        theme(plot.title = element_text(hjust = 0.5),text = element_text(size=20))
print(plot)
dev.off()

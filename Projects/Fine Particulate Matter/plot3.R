# plot3.R:
library(ggplot2)

# load data:
NEI <- readRDS("./data/summarySCC_PM25.rds")
baltimore_emissions_dt <- subset(NEI,fips=="24510")

# plot:
png("plot3.png", width=1000, height=1000)
plot <- ggplot(baltimore_emissions_dt, aes(x = factor(year), y = Emissions)) +
        geom_bar(aes(fill = type), stat="identity") + guides(fill=FALSE) + 
        facet_grid(.~type) + scale_fill_brewer(palette="Set1") +
        labs(x="Year",y="Emissions (Tons)",title="Emissions in Baltimore by Type") +
        theme(plot.title = element_text(hjust = 0.5),text = element_text(size=20))
print(plot)
dev.off()





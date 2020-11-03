# plot4.R
library(ggplot2)

# load data:
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# find coal combustion related obs.
combust_related <- grepl("Comb", SCC$Short.Name)
coal_related <- grepl("Coal", SCC$Short.Name)
coal_combust_SCC <- SCC[combust_related & coal_related,"SCC"]
coal_combust_NEI <- NEI[NEI$SCC %in% coal_combust_SCC,]

# plot:
png("plot4.png", width=1000, height=1000)
options(scipen=10)
plot <- ggplot(coal_combust_NEI, aes(x = factor(year), y = Emissions)) +
        geom_bar(aes(fill = factor(year)),stat="identity") + guides(fill=FALSE) +
        scale_fill_brewer(palette="Set1") +
        labs(x="Year",y="Emissions (Tons)",title="Emissions (Coal Combustion-related)") +
        theme(plot.title = element_text(hjust = 0.5),text = element_text(size=20))
print(plot)
dev.off()

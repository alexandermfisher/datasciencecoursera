# analysis script:

# download data if necessary:
if (!file.exists("repdata_data_StormData.csv")){
        file_url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
        download.file(file_url, destfile = paste0(getwd(), "/repdata_data_StormData.csv"), method = "curl")
        
}

# load data into R.
storm_data <- read.csv(file.path(getwd(), "repdata_data_StormData.csv"), header = TRUE)

# group data by 5 year intervals:
storm_data$BGN_DATE <- as.Date(storm_data$BGN_DATE, format = "%m/%d/%Y")
storm_data$year <- as.numeric(format(storm_data$BGN_DATE, "%Y"))
breaks <- seq(from = as.numeric(format(min(storm_data$BGN_DATE),"%Y")), to = 2012 , by = 5)
tags <- vector()
for (year in breaks){tags <- c(tags,paste0("[", year,"-", year+5,")"))}
tags <- tags[-length(tags)]
storm_data$group <- cut(storm_data$year, breaks=breaks, include.lowest=TRUE, right=FALSE, labels=tags)

#### Data Preparation for Analysis and Plots:

# subset by date and relevant columns:
relevant_cols <- c("EVTYPE","FATALITIES","INJURIES","PROPDMG","PROPDMGEXP","CROPDMG","CROPDMGEXP")
sub_data <- subset(storm_data, BGN_DATE > as.Date("1996-01-01"), select = relevant_cols)
sub_data <- subset(sub_data,(FATALITIES > 0 | INJURIES > 0 | PROPDMG > 0 | CROPDMG > 0 ))

# reformat exponents cols to actual numeric vals
KEY = c("K" = 10^3, "M" = 10^6, "B" = 10^9)
sub_data$PROPDMGEXP <- KEY[sub_data$PROPDMGEXP]
sub_data[is.na(sub_data$PROPDMGEXP),"PROPDMGEXP"] <- 10^0
sub_data$CROPDMGEXP <- KEY[sub_data$CROPDMGEXP]
sub_data[is.na(sub_data$CROPDMGEXP),"CROPDMGEXP"] <- 10^0

# calculate costs
sub_data$PROPCOST <- sub_data$PROPDMG * sub_data$PROPDMGEXP
sub_data$CROPCOST <- sub_data$CROPDMG * sub_data$CROPDMGEXP

# create health_data table by groups of Fatalities and Injuries top 10 events.
health_data <- subset(sub_data, select = c("EVTYPE", "FATALITIES", "INJURIES"))
health_data <- reshape2::melt(health_data,id.vars="EVTYPE", variable.name = "damage_type")
health_data <- aggregate(data = health_data, value ~ EVTYPE + damage_type, FUN = sum)
health_data <- data.table::setDT(health_data)[order(damage_type,-value),.SD[1:10], by=damage_type]

# create econ_data table by groups of cropcost and propcost top 10 events.
econ_data <- subset(sub_data, select = c("EVTYPE","PROPCOST","CROPCOST"))
econ_data <- reshape2::melt(econ_data,id.vars="EVTYPE", variable.name = "cost_type")
econ_data <- aggregate(data = econ_data, value~EVTYPE + cost_type, FUN = sum)
econ_data <- data.table::setDT(econ_data)[order(cost_type,-value),.SD[1:10], by=cost_type]
econ_data$value <- econ_data$value/(10^9)



#### PLOT RESULTS:

library(ggplot2)

#### Damage to Population Health PLots:
fatalities_plot <- ggplot(health_data[health_data$damage_type == "FATALITIES",], aes(x = reorder(EVTYPE,-value), y = value)) +
        geom_col(fill = "blue", alpha = 0.8, size=0.2) +
        #scale_y_continuous(limit = c(0, 20000)) +
        labs(x="Event Type",y="Number of Fatalities",title="Top 10 Storm Events by Fatalities") +
        theme(plot.title = element_text(hjust = 0.5), text = element_text(size=10), axis.text.x = element_text(angle=40, hjust=1))

injuries_plot <- ggplot(health_data[health_data$damage_type == "INJURIES",], aes(x = reorder(EVTYPE,-value), y = value)) +
        geom_col(fill = "red", alpha = 0.8, size=0.2) + 
        labs(x="Event Type",y="Number of Injuries",title="Top 10 Storm Events by Injuries") +
        theme(plot.title = element_text(hjust = 0.5), text = element_text(size=10), axis.text.x = element_text(angle=40, hjust=1))

gridExtra::grid.arrange(fatalities_plot, injuries_plot, nrow = 2)



#### Damage to Economic Health PLots:
propcost_plot <- ggplot(econ_data[econ_data$cost_type == "PROPCOST",], aes(x = reorder(EVTYPE,-value), y = value)) +
        geom_col(fill = "blue", alpha = 0.8, size=0.2) +
        #scale_y_continuous(labels = scales::scientific) +
        labs(x="Event Type",y="Total Cost (Billion USD)",title="Top 10 Storm Events by Property Costs") +
        theme(plot.title = element_text(hjust = 0.5), text = element_text(size=10), axis.text.x = element_text(angle=40, hjust=1))

cropcost_plot <- ggplot(econ_data[econ_data$cost_type == "CROPCOST",], aes(x = reorder(EVTYPE,-value), y = value)) +
        geom_col(fill = "red", alpha = 0.8, size=0.2) + 
        #scale_y_continuous(limits = c(0,1.5*10^11), labels = scales::scientific) +
        labs(x="Event Type",y="Total Cost (Billion USD)",title="Top 10 Storm Events by Crop Costs") +
        theme(plot.title = element_text(hjust = 0.5), text = element_text(size=10), axis.text.x = element_text(angle=40, hjust=1))

gridExtra::grid.arrange(propcost_plot, cropcost_plot, nrow = 2)





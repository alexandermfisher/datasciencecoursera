# analysis for R project.

# download and read data into R.
url <- "https://api.coronavirus.data.gov.uk/v2/data?areaType=utla&metric=newCasesByPublishDate&metric=newDeathsByDeathDate&format=csv"
download.file(url, destfile="uk_covid_data.csv", method="curl")
data <- read.csv(file.path(getwd(), "uk_covid_data.csv"), header = TRUE)


## Getting cumulative sum of new cases and new deaths latest entries for each region.
data <- data[!is.na(data$newCasesByPublishDate),]
data <- data[!is.na(data$newDeathsByDeathDate),]
library(dplyr)
relevant_cols <- c("date","areaName","newCasesByPublishDate","newDeathsByDeathDate")
data <- data %>% select(c("date","areaName","newCasesByPublishDate","newDeathsByDeathDate")) %>%
        group_by(areaName) %>%
        mutate(cumsumnewcase=cumsum(newCasesByPublishDate)) %>%
        mutate(cumsumnewdeath = cumsum(newDeathsByDeathDate)) %>%
        filter(row_number()==n()) %>%
        arrange(areaName)
data <- subset(data, select = c("date","areaName","cumsumnewcase","cumsumnewdeath"))

## Getting coordinate data 
coordinate_data_url <- "https://simplemaps.com/static/data/country-cities/gb/gb.csv"
download.file(coordinate_data_url, destfile="cd_data.csv", method="curl")
coordinates_uk <- read.csv(file.path(getwd(), "cd_data.csv"), header = TRUE)

data$lat <- rep(0,length(data$date))
data$lng <- rep(0,length(data$date))

for (city in data$areaName){
        if (city %in% (coordinates_uk$city)){
                data[data$areaName == city, "lat"] <- coordinates_uk[coordinates_uk$city == city, "lat"]
                data[data$areaName == city, "lng"] <- coordinates_uk[coordinates_uk$city == city, "lng"]
        } else if (city %in% coordinates_uk$admin_name){
                data[data$areaName == city, "lat"] <- colMeans(coordinates_uk[coordinates_uk$admin_name == city,c("lat","lng")])[1]
                data[data$areaName == city, "lng"] <- colMeans(coordinates_uk[coordinates_uk$admin_name == city,c("lat","lng")])[2]
        }
        else{
                data<-data[!(data$areaName == city),]
        }
}

data$popup_lables <- rep("No Info.",length(data$date))
for (i in 1:length(data$areaName)){
        data$popup_lables[i] <- paste(sep = "<br/>", paste("<b>",data$areaName[i],":</b>"),
                                      paste0("cumulative sum new cases: ",data$cumsumnewcase[i]),
                                      paste0("cumulative sum of deaths: ",data$cumsumnewdeath[i]))
}


library(leaflet)
data[,c("lat","lng")] %>%  leaflet()  %>%
        addTiles() %>%  
        addMarkers(clusterOptions = markerClusterOptions(), popup = data$popup_lables)
        #addCircles(weight = 1, radius = sqrt(data$cumsumnewdeath)*500,popup = data$areaName)






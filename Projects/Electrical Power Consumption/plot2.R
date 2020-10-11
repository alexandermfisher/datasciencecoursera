# load data into workspace:
setwd(paste0("~/Documents/R_Programming/",
             "Data_Science_Specialisation_Course_in_R/draft_material/Assesments/Electrical Power Consumption"))
dt <- data.table::fread(input = "./data/household_power_consumption.txt", na.strings="?")

# Format Global_active_power and add datetime col:
dt[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
dt[, datetime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Subset by relevant Dates:
dt <- subset(dt,(datetime >= "2007-02-01") & (datetime < "2007-02-03"))

# Plot into png file:
png("plot2.png", width=480, height=480)
with(dt, plot(datetime, Global_active_power,type="l", 
              xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
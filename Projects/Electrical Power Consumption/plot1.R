# load data into workspace:
setwd(paste0("~/Documents/R_Programming/",
      "Data_Science_Specialisation_Course_in_R/draft_material/Assesments/Electrical Power Consumption"))
dt <- data.table::fread(input = "./data/household_power_consumption.txt", na.strings="?")

# Format Date and Global_active_power cols:
dt[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
dt[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Subset into relevant Dates:
dt <- subset(dt,(Date >= "2007-02-01") & (Date < "2007-02-03"))

# Plot histogram into png file:
png("plot1.png", width=480, height=480)
hist(dt[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()
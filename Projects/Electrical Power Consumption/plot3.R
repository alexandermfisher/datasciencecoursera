# load data into workspace:
setwd(paste0("~/Documents/R_Programming/",
             "Data_Science_Specialisation_Course_in_R/draft_material/Assesments/Electrical Power Consumption"))
dt <- data.table::fread(input = "./data/household_power_consumption.txt", na.strings="?")

# Format data and subset by dates:
cols = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
dt[, (cols) := lapply(.SD, as.numeric), .SDcols = cols]
dt[, datetime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
dt <- subset(dt,(datetime >= "2007-02-01") & (datetime < "2007-02-03"))

# Plot into png file:
png("plot3.png", width=480, height=480)
with(dt,plot(datetime,Sub_metering_1,type="l",col="black", xlab="", ylab="Energy sub metering"))
with(dt,lines(datetime,Sub_metering_2,col="red"))
with(dt,lines(datetime,Sub_metering_3,col="blue"))
legend("topright", col=c("black","red","blue"), lty=c(1,1,1), lwd=c(1,1,1), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "))
dev.off()

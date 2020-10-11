# load data into workspace:
dt <- data.table::fread(input = "./data/household_power_consumption.txt", na.strings="?")

# # Format data and subset by dates:
# cols = c("Global_active_power","Sub_metering_1","Sub_metering_2","Sub_metering_3","Voltage","Global_reactive_power")
# dt[, (cols) := lapply(.SD, as.numeric), .SDcols = cols]
dt[, datetime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
dt <- subset(dt,(datetime >= "2007-02-01") & (datetime < "2007-02-03"))

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# plot (1,1):
with(dt, plot(datetime, Global_active_power,type="l",xlab="", ylab="Global Active Power"))
# plot (1,2):
with(dt, plot(datetime, Voltage,type="l",xlab="datetime", ylab="Voltage"))
# plot (2,1):
with(dt,plot(datetime,Sub_metering_1,type="l",col="black", xlab="", ylab="Energy sub metering"))
with(dt,lines(datetime,Sub_metering_2,col="red"))
with(dt,lines(datetime,Sub_metering_3,col="blue"))
legend("topright", col=c("black","red","blue"), lty=c(1,1,1), lwd=c(1,1,1), bty="n",cex=0.9, 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "))
# plot (2,2):
with(dt, plot(datetime, Global_reactive_power,type="l",xlab="datetime", ylab="Global_reactive_power"))
dev.off()


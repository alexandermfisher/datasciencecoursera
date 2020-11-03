### Exploratory Data Analysis Project 1 - Electrical Power Consumption:

*Author: Alexander M Fisher*  

 **********
 
This is the first course project for the Exploratory Data Analysis module apart of the Coursera Data Science Specialization. Included in this repository are the r scripts `plot1.R`, `plot2.R`, `plot3.R`, `plot4.R`, and their corresponding output .png files with the same respective names. The `data` directory is also included in this repository which contains the relevant data file `household_power_consumption.txt`. 

**********

#### Data:

[Electrical Power Consumption](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip) [20Mb]

**********

#### Files:

- `data/household_power_consumption.txt`: dataset used for creating plots.
- `plot1.R`: script that produced `plot1.png`
- `plot2.R`: script that produced `plot2.png`
- `plot3.R`: script that produced `plot3.png`
- `plot4.R`: script that produced `plot4.png`
- `plot1.png`: Global Active Power Histogram plot.
- `plot2.png`:line plot of global active power vs time.
- `plot3.png`: line plots of sub metering vs time.
- `plot4.png`: combination of 4 line plots for global active and reactive power vs time. 

**********

#### Code and Resulting Plots:

##### plot1:

```r
# load data into workspace:
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
```

![](plot1.png)

##### plot2:

```r
# load data into workspace:
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
```

![](plot2.png)

##### plot3:

```r
# load data into workspace:
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
```

![](plot3.png)


##### plot4:

```r
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
```

![](plot4.png)








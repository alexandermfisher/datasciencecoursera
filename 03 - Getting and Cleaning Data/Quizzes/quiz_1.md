## Quiz 1:

### Question 1:

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

How many housing units in this survey were worth more than $1,000,000?

#### Answer:

53

```r
library(data.table)
housing <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
housing[VAL == 24, .N]
```

### Question 2:

Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

#### Answer:

Tidy data one variable per column.

(Both Family Type and Employment Status are in the one column.)

### Question 3:

Download the Excel spreadsheet on Natural Gas Aquisition Program here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx

Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:

dat

What is the value of: `sum(dat$Zip*dat$Ext,na.rm=T)`

#### Answer:

36534720

```r
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = paste0(getwd(), '/data.xlsx'), method = "curl")
dat <- xlsx::read.xlsx(file = "data.xlsx", sheetIndex = 1, rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)
```
### Question 4:

Read the XML data on Baltimore restaurants from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

How many restaurants have zipcode 21231?

#### Answer:

127

```r
URL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- XML::xmlTreeParse(sub("s", "", fileURL), useInternal = TRUE)
zipcodes <- XML::xpathSApply(doc, "//zipcode", XML::xmlValue)
sub <- zipcodes[zipcodes %in% c("21231")]
length(sub)

# or alternatively:
zipcode_dt <- data.table::data.table(zipcode = zipcodes)
xmlZipcode_dt[zipcode == "21231", .N]
```

### Question 5:

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

using the fread() command load the data into an R object 'DT'

Which of the following is the fastest way to calculate the average value of the variable `pwgtp15` broken down by sex using the data.table package?

#### Answer:

```r
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
> download.file(fileURL,paste0(getwd(),'/data.csv'),method='curl')
 DT <- data.table::fread("data.csv")
 DT[,mean(pwgtp15),by=SEX]
 
 ###
 system.time(DT[,mean(pwgtp15),by=SEX])
   user  system elapsed 
  0.001   0.001   0.001 
###
```










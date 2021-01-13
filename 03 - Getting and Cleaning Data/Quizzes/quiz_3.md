## Getting and Cleaning Data Quiz 3:

### Question 1:

The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical)

What are the first 3 values that result?

#### Answer:

125 238 262

```r
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileURL, 'ACS.csv', method='curl' )
data <- read.csv('ACS.csv')
agricultureLogical <- data$ACR == 3 & data$AGS == 6
head(which(agricultureLogical), 3)
```
### Question 2:

Using the jpeg package read in the following picture of your instructor into R

https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?

#### Answer:

30%: -15259150, 80%: -10575416 

```r
fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(fileURL,'pic.jpg', mode='wb' )
picture <- jpeg::readJPEG('pic.jpg',native=TRUE)
quantile(picture,probs=c(0.3, 0.8))
```
### Question 3:

Load the Gross Domestic Product data for the 190 ranked countries in this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank. What is the 13th country in the resulting data frame?

#### Answer:

189, St. Kitts and Nevis

```r
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
data_1 <- fread(fileurl,skip = 5, nrows = 190,select = c(1,2,4,5),col.names=c("CountryCode", "Rank", "Economy", "Total"))
data_2 <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

merged_data <- merge(data_1, data_2, by = 'CountryCode')
nrow(merged_data)

merged_data <- merged_data[order(-Rank)][13,Economy]
```
### Question 4:

What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

#### Answer:

High income: OECD: 32.96667
High income: nonOECD: 91.91304

```R
res<-merged_data[,.(mean = mean(Rank)),by="Income Group"]
res[res$`Income Group`=="High income: nonOECD",mean]
res[res$`Income Group`=="High income: OECD",mean]
```

### Question 5:

Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

#### Answer:

5

```r
breaks <- quantile(merged_data[, Rank], probs = seq(0, 1, 0.2), na.rm = TRUE)
merged_data$quantileGDP <- cut(merged_data[, Rank], breaks = breaks)
merged_data[`Income Group` == "Lower middle income", .N, by = c("Income Group", "quantileGDP")]

# Answer 
#           Income Group quantileGDP  N
# 1: Lower middle income (38.6,76.2] 13
# 2: Lower middle income   (114,152]  9
# 3: Lower middle income   (152,190] 16
# 4: Lower middle income  (76.2,114] 11
# 5: Lower middle income    (1,38.6]  5

```




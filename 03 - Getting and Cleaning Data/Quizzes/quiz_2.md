## Getting and Cleaning Data Quiz 2:

### Question 1:

Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?

#### Answer:

2013-11-07T13:25:07Z

### Question 2:

The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.

Download the American Community Survey data and load it into an R object called `acs`

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

#### Answer:

`query1 <- sqldf("select pwgtp1 from acs where AGEP < 50")`

```r
library("sqldf")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(url, file.path(getwd(),"data.csv"))
acs <- fread("data.csv")
query1 <- sqldf("select pwgtp1 from acs2 where AGEP < 50")
```

### Question 3:

Using the same data frame you created in the previous problem, what is the equivalent function to `unique(acs$AGEP)`

#### Answer:

`sqldf("select distinct AGEP from acs")`

### Question 4:

How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:

http://biostat.jhsph.edu/~jleek/contact.html

#### Answer:

45 31 7 25

```r
connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection,n=100)
close(connection)
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))
```

### Question 5:

Read this data set into R and report the sum of the numbers in the fourth of the nine columns.

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for

#### Answer:

32426.7

```r
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
w <- c(1, 9, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3, 5, 4, 1, 3)
colNames <- c("filler", "week", "filler", "sstNino12", "filler", "sstaNino12",
               "filler", "sstNino3", "filler", "sstaNino3", "filler", "sstNino34", "filler", 
               "sstaNino34", "filler", "sstNino4", "filler", "sstaNino4")
d <- read.fwf(url, w, header = FALSE, skip = 4,col.names = colNames)
sum(d[,"sstNino3"])
```

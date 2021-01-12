## Quiz 1:

### Question 1:

R was developed by statisticians working at...?

###€ Answer: 

The University of Auckland

### Question 2:

The definition of free software consists of four freedoms (freedoms 0 through 3). Which of the following is NOT one of the freedoms that are part of the definition?

#### Answer:

The freedom to sell the software for any price.

### Question 3:

In R the following are all atomic data types EXCEPT?

#### Answer:

matrix

### Question 4:

If I execute the expression `x <- 4` in R, what is the class of the object `x` as determined by the 'class()' function?

#### Answer:

numeric (see code below)

```r
x <- 4
class(x)
```
    ## [1] "numeric"

### Question 5:

What is the class of the object defined by `x <- c(4, TRUE)`?

#### Answer:

numeric (see code below)

```r
x <- c(4,TRUE)
class(x)
```
    ## [1] "numeric"

### Question 6: 

If I have two vectors `x <- c(1,3, 5)` and `y <- c(3, 2, 10)`, what is produced by the expression `rbind(x, y)`?

#### Answer:

a 2 by 3 numeric matrix/array. 

```r
x <- c(1,3,5)
y <- c(3,2,10)
rbind(x,y)
```
### Question 7:

A key property of vectors in R is that

#### Answer:

elements of a vector all must be of the same class

### Question 8:

Suppose I have a list defined as `x <- list(2, "a", "b", TRUE)`. What does `x[[2]]` give me?

#### Answer:

a character vector containing the element "a"

```r
x <- list(2, "a", "b", TRUE)
x[[1]]
```
    ## [1] 2

### Question 9:

Suppose I have a vector `x <- 1:4` and a vector `y <- 2:3`. What is produced by the expression `x + y`?

#### Answer:

a integer vector with elements 3, 5, 5, 7.

```r
x <- 1:4
y <- 2:3
x + y
```

### Question 10:

Suppose I have a vector x <- c(3, 5, 1, 10, 12, 6) and I want to set all elements of this vector that are less than 6 to be equal to zero. What R code achieves this? Select all that apply.

#### Answer:

`x[x < 6 ] <- 0`

### Question 11:

In the dataset provided for this Quiz, what are the column names of the dataset?

#### Answer:

Ozone, Solar.R, Wind, Temp, Month, Day

```r
library("data.table")
data <- fread('hw1_data.csv')
names(data)
```

### Question 12:

Extract the first 2 rows of the data frame and print them to the console. What does the output look like?

#### Answer:

```r
  Ozone Solar.R Wind Temp Month Day
1    41     190  7.4   67     5   1
2    36     118  8.0   72     5   2
```

### Question 13:

How many observations (i.e. rows) are in this data frame?

#### Answer:

153. Use r-function `nrow(data)`.

### Question 14:

Extract the last 2 rows of the data frame and print them to the console. What does the output look like?

#### Answer:

Use `tail(dat,2)`. 

```r
    Ozone Solar.R Wind Temp Month Day
152    18     131  8.0   76     9  29
153    20     223 11.5   68     9  30
```

### Question 15:

What is the value of Ozone in the 47th row?

#### Answer:

21. Use `data[47, 'Ozone']`

### Question 16:

How many missing values are in the Ozone column of this data frame?

#### Answer:

37

```r
sub = subset(airquality, is.na(Ozone))
nrow(sub)
```
    ## [1] 37
    
### Question 17:

What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.

#### Answer:

42.13

```r
sub_data <- data[complete.cases(data$Ozone),]
mean(sub_data$Ozone)
```

### Question 18:

Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?

#### Answer:

212.8

```r
sub_data = subset(data, Ozone > 31 & Temp > 90, select = Solar.R)
mean(sub_data$Solar.R,na.rm=TRUE)
```

### Question 19:

What is the mean of "Temp" when "Month" is equal to 6?

#### Answer:

79.1

```r
sub_data = subset(data, Month == 6, select = Temp)
mean(sub_data$Temp,na.rm=TRUE)
```
    ## [1] 79.1
    
### Question 20:

What was the maximum ozone value in the month of May (i.e. Month = 5)?

#### Answer:

115

```r
sub_data = subset(data, Month == 5 & !is.na(Ozone), select = Ozone)
max(sub_data)
```
    ## [1] 115
    




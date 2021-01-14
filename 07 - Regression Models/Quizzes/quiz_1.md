####  Regression Models Quiz 1:
*Author: Alexander M Fisher*

**********

##### Question 1:

Consider the data set given below

```r
x <- c(0.18, -1.54, 0.42, 0.95)
```

And weights given by

```r
w <- c(2, 1, 3, 1)
```

Give the value of $\mu$ that minimizes the least squares equation

$\sum_{i=1}^{n}w_{i}\left ( x_{i} -\mu \right)^{2}$  
  
  
###### Answer:  
  
$\mu = \frac{\sum_{i=1}^{n}w_{i}x_{i}}{\sum_{i=1}^{n}w_{i}}$  
  
```r
mu <- sum(w*x)/sum(w); mu
```
```r
## [1] 0.1471429
```

**********

##### Question 2:

Consider the following data set

```r
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
```

Fit the regression through the origin and get the slope treating y as the outcome and x as the 
regressor. (Hint, do not center the data since we want regression through the origin, not through the means of the data.)

- 0.59915
- 0.8263
- -1.713
- -0.04462

###### Answer:

```r
lm(y~x-1)$coefficients
```
```r
## [1] 0.8262517
```

**********

##### Question 3:

Do `data(mtcars)` from the datasets package and fit the regression 
model with mpg as the outcome and weight as the predictor. Give the slope coefficient.

- 0.5591
- 30.2851
- -5.344
- -9.559

###### Answer:

```r
lm(mtcars$mpg~mtcars$wt)$coefficients
```
```r
## (Intercept)   mtcars$wt 
##  37.285126   -5.344472 
```

So slope coefficient is -5.344

**********

##### Question 4:

Consider data with an outcome (Y) and a predictor (X). The standard deviation of the predictor 
is one half that of the outcome. The correlation between the two variables is .5. 
What value would the slope coefficient for the regression model with YY as the outcome and XX as the predictor?



- 0.25
- 3
- 1
- 4

###### Answer:

For simple linear regression where Y is the outcome and X is the predictor the slope parameter is given by,

$\beta = Cor\left ( Y,X \right ) \frac{Sd\left ( Y \right )}{Sd\left ( X \right )}$

Plugging in the numbers results in $\beta = 1$.

**********

##### Question 5:

Students were given two hard tests and scores were normalized to have empirical mean 0 and variance 1. The correlation between the scores on the two tests was 0.4. What would be the expected score on Quiz 2 for a student who had a normalized score of 1.5 on Quiz 1?

- 1.0
- 0.4
- 0.16
- 0.6

###### Answer:

As the data is normalized the correlation is equal to the slope (i.e. $\beta = 0.4$). That is to say $test_{2} = 0.4*test_{1} = 0.4*1.5 = 0.6$

**********

##### Question 6:

Consider the data given by the following `x <- c(8.58, 10.46, 9.01, 9.64, 8.86)`. What is the value of the 
first measurement if x were normalized (to have mean 0 and variance 1)?

###### Answer:

To normalize subtract mean and divide by standard deviation.

```r
(x[1]-mean(x))/sd(x)
```
```r
## [1] -0.9718658
```

**********

##### Question 7:

Consider the following data set (used above as well). What is the intercept for fitting the model with x as the predictor and y as the outcome?

```r
x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)
```

###### Answer:

```r
lm(y~x)$coefficients[1]
```
```r
## (Intercept) 
##   1.567461 
```

**********

##### Question 8:

You know that both the predictor and response have mean 0. What can be said about the intercept when you fit a linear regression?

- It must be identically 0.
- It must be exactly one.
- Nothing about the intercept can be said from the information given.
- It is undefined as you have to divide by zero.

###### Answer:

It must be identically 0.

**********

##### Question 9:

Consider the data given by `x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)`. What value 
minimizes the sum of the squared distances between these points and itself.

- 0.36
- 0.44
- 0.573
- 0.8

###### Answer:

The mean. `mean(x) = 0.573`

**********

##### Question 10:

Let the slope having fit Y as the outcome and X as the predictor be denoted as $\beta_{1}$. 
Let the slope from fitting X as the outcome and Y as the predictor be denoted as $\gamma_{1}$.
Suppose that you divide $\beta_{1}$ by $\gamma_{1}$; in other words consider $\beta_{1}/\gamma_{1}. What is this ratio always equal to?

- 1
- Var(Y)/Var(X)
- 2SD(Y)/SD(X)
- Cor(Y,X)

###### Answer:

Var(Y)/Var(X)

**********


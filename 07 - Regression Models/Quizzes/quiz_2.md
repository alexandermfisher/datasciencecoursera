####  Regression Models Quiz 2:
*Author: Alexander M Fisher*

**********

##### Question 1:

Consider the following data with x as the predictor and y as as the outcome.

```r
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
```

Give a P-value for the two sided hypothesis test of whether $\beta_{1}$ from a linear regression model is 0 or not.

- 0.05296
- 2.325
- 0.025
- 0.391

###### Answer:

```r
fit <- lm(y ~ x)
summary(fit)$coefficients
```
```r
##              Estimate Std. Error   t value   Pr(>|t|)
## (Intercept) 0.1884572  0.2061290 0.9142681 0.39098029
## x           0.7224211  0.3106531 2.3254912 0.05296439
```

It can be seen the p-value for the slope parameter is 0.05296439

**********

##### Question 2:

Consider the previous problem, give the estimate of the residual standard deviation.

- 0.4358
- 0.3552
- 0.05296
- 0.223

###### Answer:

```r
fit <- lm(y ~ x)
summary(fit)$sigma
```
```r
## [1] 0.2229981
```

**********

##### Question 3:

In the `mtcars` data set, fit a linear regression model of weight (predictor) on mpg (outcome). Get a 95% confidence interval for the expected mpg at the average weight. What is the lower endpoint?

###### Answer:

```r
data(mtcars)
y <- mtcars$mpg
x <- mtcars$wt
fit <- lm(y ~ x)
print(predict(fit, newdata = data.frame(x = mean(x)), interval = ("confidence"))[2])
```
```r
## [1] 18.99098
```

**********

##### Question 4:

Refer to the previous question. Read the help file for `mtcars`. What is the weight coefficient interpreted as?

- The estimated 1,000 lb change in weight per 1 mpg increase.
- The estimated expected change in mpg per 1 lb increase in weight.
- The estimated expected change in mpg per 1,000 lb increase in weight.
- It can't be interpreted without further information

###### Answer:

The estimated expected change in mpg per 1,000 lb increase in weight.

**********

##### Question 5:

Consider again the `mtcars` data set and a linear regression model with mpg as predicted by weight (1,000 lbs). 
A new car is coming weighing 3000 pounds. Construct a 95% prediction interval for its mpg. What is the upper endpoint?

- -5.77
- 27.57
- 21.25
- 14.93

###### Answer:

```r
data(mtcars)
x0 <- 3
y <- mtcars$mpg
x <- mtcars$wt
fit <- lm(y ~ x)
print(predict(fit, newdata = data.frame(x = x0), interval = ("confidence"))[1])
```
```r
## [1] 21.25171
```

**********

##### Question 6:

Consider again the `mtcars` data set and a linear regression model with mpg as predicted by weight (in 1,000 lbs). 
A “short” ton is defined as 2,000 lbs. Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight. Give the lower endpoint.

- 4.2026
- -9.000
- -12.973
- -6.486

###### Answer:

```r
data(mtcars)
y <- mtcars$mpg
x <- mtcars$wt
fit <- lm(y ~ x)
print(2*coef(summary(fit))[2,1] + c(-1)*qt(0.975,df=fit$df)*2*coef(summary(fit))[2,2])
```
```r
## [1] -12.97262
```

**********

##### Question 7:

If my X from a linear regression is measured in centimeters and I convert it to meters what would happen to the slope coefficient?

- It would get multiplied by 100.
- It would get multiplied by 10
- It would get divided by 100
- It would get divided by 10

###### Answer:

It would get multiplied by 100.

**********

##### Question 8:

Question 8
I have an outcome, Y, and a predictor, X and fit a linear regression model with Y = $\beta_{0}$ + $\beta_{1}X$ + $\epsilon$ to obtain $\hat {\beta_{0}}$ and $\hat{ \beta_{1}}$. What would be the consequence to the subsequent slope and intercept if I were to refit the model with a new regressor, $X + c$ for some constant, c?



- The new intercept would be $\hat {\beta_{0}}$ + c$\hat{ \beta_{1}}$ 
- The new slope would be c$\hat{\beta_{1}}$ 
- The new slope would be $\hat {\beta_{1}} + c$
- The new intercept would be $\hat{ \beta_{0}} - c \hat {\beta_{1}}$ 
	
###### Answer:

The new intercept would be $\hat{ \beta_{0}} - c \hat {\beta_{1}}$

**********

##### Question 9:

Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor. 
About what is the ratio of the the sum of the squared errors, $\sum_{i=1}^{n}\left ( Y_{i}-\hat{Y_{i}} \right )^{2}$
  when comparing a model with just an intercept (denominator) to the model with the intercept and slope (numerator)?

- 4.00
- 0.25
- 0.75
- 0.50

###### Answer:

```r
data(mtcars)
y <- mtcars$mpg
x <- mtcars$wt
fit <- lm(y ~ x)
round(sum(resid(fit)^2)/(sum((y-mean(y))^2)),2)
```
```r
## [1] 0.25
```

**********

##### Question 10:

Do the residuals always have to sum to 0 in linear regression?

- The residuals must always sum to zero.
- The residuals never sum to zero.
- If an intercept is included, then they will sum to 0.
- If an intercept is included, the residuals most likely won't sum to zero.

###### Answer:

If an intercept is included, then they will sum to 0.

**********


####  Regression Models Quiz 3:
*Author: Alexander M Fisher*

**********

##### Question 1:

Consider the `mtcars` data set. Fit a model with mpg as the outcome that includes number of cylinders as a factor variable and weight as confounder. Give the adjusted estimate for the expected change in mpg comparing 8 cylinders to 4.

- -6.071
- 33.991
- -4.256
- -3.206

###### Answer:

```r
data("mtcars")
data <- mtcars
data$cyl <- as.factor(data$cyl)
fit<-lm(mpg~cyl+wt, data = data)
fit$coefficients
```
```r
## (Intercept)       mcyl6       mcyl8          wt 
## 33.990794   -4.255582   -6.070860   -3.205613 
````

So -6.071

**********

##### Question 2:

Consider the `mtcars` data set. Fit a model with mpg as the outcome that includes number of cylinders as a factor variable and weight as a possible confounding variable. Compare the effect of 8 versus 4 cylinders on mpg for the adjusted and unadjusted by weight models. Here, adjusted means including the weight variable as a term in the regression model and unadjusted means the model without weight included. What can be said about the effect comparing 8 and 4 cylinders after looking at models with and without weight included?.

- Including or excluding weight does not appear to change anything regarding the estimated impact of number of cylinders on mpg.
- Holding weight constant, cylinder appears to have more of an impact on mpg than if weight is disregarded.
- Within a given weight, 8 cylinder vehicles have an expected 12 mpg drop in fuel efficiency.
- Holding weight constant, cylinder appears to have less of an impact on mpg than if weight is disregarded.

###### Answer:

```r
fit<-lm(mpg~cyl+wt, data = data)
fit$coefficients
fit<-lm(mpg~cyl, data = data)
fit$coefficients
```
```r
## (Intercept)        cyl6        cyl8          wt 
##  33.990794   -4.255582   -6.070860   -3.205613 
## (Intercept)        cyl6        cyl8 
##   26.663636   -6.920779  -11.563636 
```

Holding weight constant, cylinder appears to have less of an impact on mpg than if weight is disregarded.

**********

##### Question 3:

Question 3
Consider the `mtcars` data set. Fit a model with mpg as the outcome that considers number of cylinders as a factor variable and weight as confounder. Now fit a second model with mpg as the outcome model that considers the interaction between number of cylinders (as a factor variable) and weight. Give the P-value for the likelihood ratio test comparing the two models and suggest a model using 0.05 as a type I error rate significance benchmark.

- The P-value is larger than 0.05. So, according to our criterion, we would fail to reject, which suggests that the interaction terms may not be necessary.
- The P-value is small (less than 0.05). Thus it is surely true that there is an interaction term in the true model.
- The P-value is larger than 0.05. So, according to our criterion, we would fail to reject, which suggests that the interaction terms is necessary.
- The P-value is small (less than 0.05). So, according to our criterion, we reject, which suggests that the interaction term is not necessary.
- The P-value is small (less than 0.05). So, according to our criterion, we reject, which suggests that the interaction term is necessary
- The P-value is small (less than 0.05). Thus it is surely true that there is no interaction term in the true model.

###### Answer:

```r
fit_1<-lm(mpg~cyl+wt, data = data)
fit_2<-lm(mpg~cyl*wt, data = data)
print(anova(fit_1,fit_2))
```
```r
## Analysis of Variance Table
##
## Model 1: mpg ~ cyl + wt
## Model 2: mpg ~ cyl * wt
##   Res.Df    RSS Df Sum of Sq      F Pr(>F)
## 1     28 183.06                           
## 2     26 155.89  2     27.17 2.2658 0.1239
```

The P-value is larger than 0.05. So, according to our criterion, we would fail to reject, which suggests that the interaction terms may not be necessary.

**********

##### Question 4:

Consider the `mtcars` data set. Fit a model with mpg as the outcome that includes number of cylinders as a 
factor variable and weight included in the model as

```r
lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
```

How is the wt coefficient interpreted?

- The estimated expected change in MPG per half ton increase in weight for for a specific number of cylinders (4, 6, 8).
- The estimated expected change in MPG per half ton increase in weight.
- The estimated expected change in MPG per half ton increase in weight for the average number of cylinders.
- The estimated expected change in MPG per one ton increase in weight.
- The estimated expected change in MPG per one ton increase in weight for a specific number of cylinders (4, 6, 8).

###### Answer:

The estimated expected change in MPG per one ton increase in weight for a specific number of cylinders (4, 6, 8).

**********

##### Question 5:

Consider the following data set

```r
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
```

Give the hat diagonal for the most influential point

- 0.2804
- 0.2287
- 0.2025
- 0.9946

###### Answer:

```r
fit <- lm(y~x)
print(max(hatvalues(fit)))
```
```r
## [1] 0.9945734
````

0.9946

**********

##### Question 6:

Consider the following data set

```r
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
```

Give the slope dfbeta for the point with the highest hat value.

- -0.378
- 0.673
- -.00134
- -134

###### Answer:

```r
fit <- lm(y~x)
row_index <- which(hatvalues(fit)==max(hatvalues(fit)))
print(dfbetas(fit)[row_index,2])
```
```r
[1] -133.8226
```

**********

##### Question 7:

Consider a regression relationship between Y and X with and without adjustment for a third variable Z. Which of the following is true about comparing the regression coefficient between Y and X with and without adjustment for Z.

- For the the coefficient to change sign, there must be a significant interaction term.
- The coefficient can't change sign after adjustment, except for slight numerical pathological cases.
- It is possible for the coefficient to reverse sign after adjustment. For example, it can be strongly significant and positive before adjustment and strongly significant and negative after adjustment.
- Adjusting for another variable can only attenuate the coefficient toward zero. It can't materially change sign.

###### Answer:

It is possible for the coefficient to reverse sign after adjustment. For example, it can be strongly significant and positive before adjustment and strongly significant and negative after adjustment.

**********




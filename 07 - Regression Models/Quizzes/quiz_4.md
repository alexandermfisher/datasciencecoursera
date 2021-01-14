####  Regression Models Quiz 4:
*Author: Alexander M Fisher*

**********

##### Question 1:

Consider the space shuttle data `?shuttle` in the `MASS` library. Consider modeling the use of the autolander as the outcome (variable name `use`). Fit a logistic regression model with autolander (variable auto) use (labeled as "auto" 1) versus not (0) as predicted by wind sign (variable wind). Give the estimated odds ratio for autolander use comparing head winds, labeled as "head" in the variable headwind (numerator) to tail winds (denominator).

- 0.969
- -0.031
- 1.327
- 0.031


###### Answer:

```r
library(MASS)
data("shuttle")
data <- shuttle
data$use <- 1*(data$use == "auto")
fit <- glm(data$use~data$wind-1, family = binomial(link="logit"))
print(exp(summary(fit)$coef[1,1]-summary(fit)$coef[2,1]))
```
```r
## [1] 0.9686888
```

**********

##### Question 2:

Consider the previous problem. Give the estimated odds ratio for autolander use comparing head winds (numerator) to tail winds (denominator) adjusting for wind strength from the variable magn.

- 1.485
- 0.969
- 0.684
- 1.00

###### Answer:

```r
fit_2 <- glm(data$use~data$wind + data$magn -1, family = binomial(link="logit"))
print(exp(summary(fit_2)$coef[1,1]-summary(fit_2)$coef[2,1]))
```
```r
## [1] 0.9684981
```

**********

##### Question 3:

If you fit a logistic regression model to a binary variable, for example use of the autolander, then fit a logistic regression model for one minus the outcome (not using the autolander) what happens to the coefficients?

- The coefficients reverse their signs.
- The intercept changes sign, but the other coefficients don't.
- The coefficients change in a non-linear fashion.
- The coefficients get inverted (one over their previous value).

###### Answer:

The coefficients reverse their signs.

**********

##### Question 4:

Consider the insect spray data `InsectSprays`. Fit a Poisson model using spray as a factor level. Report the estimated relative rate comparing spray A (numerator) to spray B (denominator).

- 0.321
- 0.9457
- -0.056
- 0.136

###### Answer:

```r
data("InsectSprays")
data <- InsectSprays
fit <- glm(data$count ~ data$spray -1, family = "poisson")
print(exp(summary(fit)$coef[1,1]-summary(fit)$coef[2,1]))
```
```r
## [1] 0.9456522
```
**********

##### Question 5:

Consider a Poisson glm with an offset, tt. So, for example, a model of the form `glm(count ~ x + offset(t), family = poisson)` where `x` is a factor variable comparing a treatment (1) to a control (0) and `t` is the natural log of a monitoring time. What is impact of the coefficient for `x` if we fit the model `glm(count ~ x + offset(t2), family = poisson)` where `2 <- log(10) + t?` In other words, what happens to the coefficients if we change the units of the offset variable. (Note, adding log(10) on the log scale is multiplying by 10 on the original scale.)

- The coefficient estimate is divided by 10.
- The coefficient estimate is multiplied by 10.
- The coefficient is subtracted by log(10).
- The coefficient estimate is unchanged

###### Answer:

The coefficient estimate is unchanged

**********

##### Question 6:

Consider the data

```r
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
```

Using a knot point at 0, fit a linear model that looks like a hockey stick with two lines meeting at x=0. Include an intercept term, x and the knot point term. What is the estimated slope of the line after 0?

- -1.024
- 2.037
- 1.013
- -0.183

###### Answer:

```r
splineterm <- sapply(c(0),function(knot) ((x>knot)*(x-knot)))
mat <- cbind(1,x,splineterm)
fit <- lm(y~mat-1)
print(sum(summary(fit)$coef[2:3]))
```
```r
## [1] 1.013067
```

**********


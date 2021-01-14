#### Statistical Inference Quiz 2:
*Author: Alexander M Fisher*

**********

##### Question 1:

What is the variance of the distribution of the average an IID draw of nn observations from a population with mean \muμ and variance \sigma^2σ 
2.

###### Answer:

$\frac{\sigma^2}{n}$

**********

##### Question 2:

Suppose that diastolic blood pressures (DBPs) for men aged 35-44 are normally distributed with a mean of 80 (mm Hg) and a standard deviation of 10. About what is the probability that a random 35-44 year old has a DBP less than 70?

###### Answer:

```r
pnorm(70, 80, 10)
```

```r
## [1] 0.1587
```

**********

##### Question 3:

Brain volume for adult women is normally distributed with a mean of about 1,100 cc for women with a standard deviation of 75 cc. What brain volume represents the 95th percentile?

###### Answer:

```r
qnorm(0.95, 1100, 75)
```

```r
## [1] 1223.364
```

**********

##### Question 4:

Question 4
Refer to the previous question. Brain volume for adult women is about 1,100 cc for women with a standard deviation of 75 cc. Consider the sample mean of 100 random adult women from this population. What is the 95th percentile of the distribution of that sample mean?

###### Answer:

```r
qnorm(0.95, 1100, 75/sqrt(100))
```

```r
## [1] 1112.336
```

**********

##### Question 5:

You flip a fair coin 5 times, about what's the probability of getting 4 or 5 heads?

###### Answer:

```r
1-pbinom(3, size = 5, prob = 0.5)
```

```r
## [1] 0.1875
```

**********

##### Question 6:

The respiratory disturbance index (RDI), a measure of sleep disturbance, for a specific population has a mean of 15 (sleep events per hour) and a standard deviation of 10. They are not normally distributed. Give your best estimate of the probability that a sample mean RDI of 100 people is between 14 and 16 events per hour?

###### Answer:

68%

**********

##### Question 7:

Consider a standard uniform density. The mean for this density is .5 and the variance is 1 / 12. You sample 1,000 observations from this distribution and take the sample mean, what value would you expect it to be near?

###### Answer:

0.5

**********

##### Question 8:

The number of people showing up at a bus stop is assumed to be Poisson with a mean of 5 people per hour. You watch the bus stop for 3 hours. About what's the probability of viewing 10 or fewer people?

###### Answer:

```r
ppois(10, lambda = 15)
```

```r
## [1] 0.1185
```

**********
#### Statistical Inference Quiz 3:
*Author: Alexander M Fisher*

**********

##### Question 1:

In a population of interest, a sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. What is a 95% Student's T confidence interval for the mean brain volume in this new population?

###### Answer:

```r
n_obs <- 9
sample_mean <- 1100
sample_sd <- 30
alpha <- 0.05
CI <- sample_mean + c(-1,1) * qt(1-alpha/2,n_obs-1) * sample_sd/sqrt(n_obs)
print(round(CI))
```
```r
## [1] 1077 1123
```

**********

##### Question 2:

A diet pill is given to 9 subjects over six weeks. The average difference in weight (follow up - baseline) is -2 pounds. What would the standard deviation of the difference in weight have to be for the upper endpoint of the 95% T confidence interval to touch 0?


###### Answer:

```r
n_obs <- 9
sample_mean <- -2
upper_bound = 0
sample_sd <- (upper_bound-sample_mean) * sqrt(n_obs)/qt(1-alpha/2,n_obs-1)
print(round(sample_sd,1))
```
```r
## [1] 2.6
```

**********

##### Question 3:

In an effort to improve running performance, 5 runners were either given a protein supplement or placebo. Then, after a suitable washout period, they were given the opposite treatment. Their mile times were recorded under both the treatment and placebo, yielding 10 measurements with 2 per subject. The researchers intend to use a T test and interval to investigate the treatment. Should they use a paired or independent group T test and interval?

- A paired interval
- You could use either
- It's necessary to use both
- Independent groups, since all subjects were seen under both systems

###### Answer:

A paired interval

**********

##### Question 4:

In a study of emergency room waiting times, investigators consider a new and the standard triage systems. To test the systems, administrators selected 20 nights and randomly assigned the new triage system to be used on 10 nights and the standard system on the remaining 10 nights. They calculated the nightly median waiting time (MWT) to see a physician. The average MWT for the new system was 3 hours with a variance of 0.60 while the average MWT for the old system was 5 hours with a variance of 0.68. Consider the 95% confidence interval estimate for the differences of the mean MWT associated with the new system. Assume a constant variance. What is the interval? 
Subtract in this order (New System - Old System).

###### Answer:

```r
new_sys_obs <- 10
new_sys_mean <- 3
new_sys_sd <- sqrt(0.6)
old_sys_obs <- 10
old_sys_mean <- 5
old_sys_sd <- sqrt(0.68)
alpha <- 0.05
total_obs <- new_sys_obs + old_sys_obs
diff <- new_sys_mean - old_sys_mean
cons_sd <- sqrt(((new_sys_obs-1)*new_sys_sd^2 + (old_sys_obs-1)*old_sys_sd^2)/(total_obs-2))
CI <- diff + c(-1, 1) * qt(1-alpha/2, total_obs-2) * cons_sd * sqrt((1/new_sys_obs + 1/old_sys_obs))
print(round(CI,2))
```
```r
## [1] -2.75 -1.25
```

**********

##### Question 5:

Suppose that you create a 95% T confidence interval. You then create a 90% interval using the same data. What can be said about the 90% interval with respect to the 95% interval?

- It is impossible to tell.
- The interval will be the same width, but shifted.
- The interval will be wider
- The interval will be narrower.

###### Answer:

The interval will be narrower

**********

##### Question 6:

To further test the hospital triage system, administrators selected 200 nights and randomly assigned a new triage system to be used on 100 nights and a standard system on the remaining 100 nights. They calculated the nightly median waiting time (MWT) to see a physician. The average MWT for the new system was 4 hours with a standard deviation of 0.5 hours while the average MWT for the old system was 6 hours with a standard deviation of 2 hours. Consider the hypothesis of a decrease in the mean MWT associated with the new treatment.

What does the 95% independent group confidence interval with unequal variances suggest vis a vis this hypothesis? (Because there's so many observations per group, just use the Z quantile instead of the T.)

- When subtracting (old - new) the interval is entirely above zero. The new system appears to be effective.
- When subtracting (old - new) the interval contains 0. The new system appears to be effective.
- When subtracting (old - new) the interval is entirely above zero. The new system does not appear to be effective.
- When subtracting (old - new) the interval contains 0. There is not evidence suggesting that the new system is effective.

###### Answer:

```r
mean_1 <- 6
mean_2 <- 4
sd_1 <- 2
sd_2 <- 0.5
n_1 <- 100
n_2 <- 100
# calculate the z-statistic
z_stat <- (mean_1 - mean_2)/sqrt(sigma_1^2/n_1 + sigma_2^2/n_2)
CI <- mean_1 - mean_2 +c(-1,1)*z_stat*sqrt(sd_1^2/n_1 + sd_2^2/n_2)
print(CI)
```
```r
## [1] 0.8564563 3.1435437
```

When subtracting (old - new) the interval is entirely above zero. The new system appears to be effective.

**********

##### Question 7:

Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects’ body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks. The average difference from follow-up to the baseline (followup - baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI over the four week period appear to differ between the treated and placebo groups? Assuming normality of the underlying data and a common population variance, calculate the relevant *90%* t confidence interval. Subtract in the order of (Treated - Placebo) with the smaller (more negative) number first.

###### Answer:

```r
n_1 <- 9
n_2 <- 9
mean_1 <- -3
mean_2 <- 1 
sd_1 <- 1.5 
sd_2 <- 1.8 
cons_sd <- sqrt(((n_1-1) * sd_1^2 + (n_2-1) * sd_2^2)/(n_1 + n_2 - 2))
CI <- mean_1 - mean_2 + c(-1, 1) * qt(0.95, n_1+n_2-2) * cons_sd* sqrt(1/n_1 + 1/n_2)
print(round(CI,2))
```
```r
## [1] -5.36 -2.64
```

**********


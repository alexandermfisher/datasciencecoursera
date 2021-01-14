#### Statistical Inference Quiz 4 :
*Author: Alexander M Fisher*

**********

##### Question 1:

A pharmaceutical company is interested in testing a potential blood pressure lowering medication. Their first examination considers only subjects that received the medication at baseline then two weeks later. The data are as follows (SBP in mmHg)

Subject | Baseline | Week 2
---     | ---      | ---
1       | 140	   | 132
2	| 138	   | 135
3	| 150	   | 151
4	| 148	   | 146
5	| 135	   | 130

Consider testing the hypothesis that there was a mean reduction in blood pressure? Give the P-value for the associated two sided T test.

(Hint, consider that the observations are paired.)

- 0.043
- 0.05
- 0.087
- 0.10

###### Answer:

```r
baseline <- c(140,138,150,148,135)
week_2 <- c(132,135,151,146,130)
df <- data.frame(baseline, week_2)
t <- t.test(df$baseline, df$week_2, paired = TRUE)
print(round(t$p.value,3))
```
```r
##  [1] 0.087
```
**********

##### Question 2:

A sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. What is the complete set of values of $\mu_0$ that a test set of $H_0$: $\mu=\mu_0$ would fail to reject the null hypothesis in a two sided 5% Students t-test?

- 1031 to 1169
- 1081 to 1119
- 1080 to 1120
- 1077 to 1123


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

##### Question 3:

Researchers conducted a blind taste test of Coke versus Pepsi. Each of four people was asked which of two blinded drinks given in random order that they preferred. The data was such that 3 of the 4 people chose Coke. Assuming that this sample is representative, report a P-value for a test of the hypothesis that Coke is preferred to Pepsi using a one sided exact test.

- 0.005
- 0.10
- 0.31
- 0.62

###### Answer:

```r
# Null Hypothesis is 0.5 people like coke and 0.5 like pepsi. Therefore 
# alternative is greater than null meaning more than 0.5 of population like coke.
test <- binom.test(3,4,p = 0.5,alternative = "greater")
print(round(test$p.value,2))
```
```r
## [1] 0.3125
```

**********

##### Question 4:

Infection rates at a hospital above 1 infection per 100 person days at risk are believed to be too high and are used as a benchmark. A hospital that had previously been above the benchmark recently had 10 infections over the last 1,787 person days at risk. About what is the one sided P-value for the relevant test of whether the hospital is *below* the standard?

- 0.11
- 0.03
- 0.52
- 0.22

###### Answer:

```r
test <- binom.test(10,1787,p=0.01,alternative = "less")
print(round(test$p.value,2))
```
```r
## [1] 0.03
```
**********

##### Question 5:

Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects’ body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks. The average difference from follow-up to the baseline (followup - baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI appear to differ between the treated and placebo groups? Assuming normality of the underlying data and a common population variance, give a pvalue for a two sided t test.

- Larger than 0.10
- Less than 0.05, but larger than 0.01
- Less than 0.01
- Less than 0.10 but larger than 0.05

###### Answer:

Less than 0.01

```r
# two sided t-test checking for significant difference between groups.
# diet pill group --> 1, and placebo group --> 2
mean_1 <- -3
sd_1 <- 1.5 
mean_2 <- 1
sd_2 <- 1.8
n_obs <- 18   # 9 in each group
alpha = 0.05
diff <- mean_1 - mean_2
const_sd <- sqrt(((n_obs/2-1)*sd_1^2 + (n_obs/2-1)*sd_2^2)/(n_obs-2))
p <- pt(q = diff/(const_sd*sqrt(1/(n_obs/2) + 1/(n_obs/2))), df = n_obs-2)
print(p)
```
```r
## [1] 5.125872e-05
```

**********

##### Question 6:

Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test of H_0 : $\mu$ = 1,078?

- Where does Brian come up with these questions?
- It's impossible to tell.
- Yes you would reject.
- No you wouldn't reject.

###### Answer:

No you wouldn't reject.

**********

##### Question 7:

Researchers would like to conduct a study of 100100 healthy adults to detect a four year mean brain volume loss of $.01~mm^3$. Assume that the standard deviation of four year volume loss in this population is $.04~mm^3$. About what would be the power of the study for a 5% one sided test versus a null hypothesis of no volume loss?

- 0.60
- 0.70
- 0.80
- 0.50


###### Answer:

```r
n <- 100 
mua <- 0.01
mu0 = 0
sd <- 0.04
alpha <- 0.05 

power <- power.t.test(n, delta = mua-mu0, sd, sig.level=alpha, type="one.sample", alt="one.sided")$power
print(round(power, 2))

# or alternative sol by calculating probability directly with pnorm for alt_hypo true ie. mua correct population mean.
z <- qnorm(1-alpha)
p <- pnorm(mu0 + z * sd/sqrt(n), mean = mua, sd = sd/sqrt(n), lower.tail = FALSE)
print(round(p,2))
```
```r
## [1] 0.8
## [1] 0.8
```

**********

##### Question 8:

Researchers would like to conduct a study of *n* healthy adults to detect a four year mean brain volume loss of $.01~mm^3$. Assume that the standard deviation of four year volume loss in this population is $.04~mm^3$. About what would be the value of *n* needed for 90% power of type one error rate of 5% one sided test versus a null hypothesis of no volume loss?

###### Answer:

```r
mua <- 0.01
mu0 <- 0
sd <- 0.04
alpha <- 0.05 
power <- 0.9 

n <- power.t.test(power=power, delta=mua-mu0, sd=sd, sig.level=alpha, type="one.sample", alt="one.sided")$n
print(n)
```
```
## [1] 138.3856      # so the answer is 140
```
**********

##### Question 9:

As you increase the type one error rate, $\alpha$, what happens to power?

###### Answer:

You will get larger power.

**********



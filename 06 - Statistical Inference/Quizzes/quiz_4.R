# quiz 4 code:

# 1. 
baseline <- c(140,138,150,148,135)
week_2 <- c(132,135,151,146,130)
df <- data.frame(baseline, week_2)
test <- t.test(df$baseline, df$week_2, paired = TRUE)
print(round(test$p.value,3))

# 2.
n_obs <- 9
sample_mean <- 1100
sample_sd <- 30
alpha <- 0.05
CI <- sample_mean + c(-1,1) * qt(1-alpha/2,n_obs-1) * sample_sd/sqrt(n_obs)
print(round(CI))

# 3.
# Null Hypothesis is 0.5 people like coke and 0.5 like pepsi. Therefore 
# alternative is greater than null meaning more than 0.5 of population like coke.
test <- binom.test(3,4,p = 0.5,alternative = "greater")
print(round(test$p.value,2))

# 4. Can use poisson.test as well.
test <- binom.test(10,1787,p=0.01,alternative = "less")
print(round(test$p.value,10))

# 5.
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

# 6.

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

mua <- 0.01
mu0 <- 0
sd <- 0.04
alpha <- 0.05 
power <- 0.9 

n <- power.t.test(power=power, delta=mua-mu0, sd=sd, sig.level=alpha, type="one.sample", alt="one.sided")$n
print(n)



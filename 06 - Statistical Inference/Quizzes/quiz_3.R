
n_obs <- 9
sample_mean <- 1100
sample_sd <- 30
alpha <- 0.05
CI <- sample_mean + c(-1,1) * qt(1-alpha/2,n_obs-1) * sample_sd/sqrt(n_obs)
print(CI)
print(round(CI))

n_obs <- 9
sample_mean <- -2
upper_bound = 0
sample_sd <- (upper_bound-sample_mean) * sqrt(n_obs)/qt(1-alpha/2,n_obs-1)
print(round(sample_sd,2))


new_sys_obs <- 10
new_sys_mean <- 3
new_sys_sd <- sqrt(0.6)
old_sys_obs <- 10
old_sys_mean <- 5
old_sys_sd <- sqrt(0.68)
alpha <- 0.05
total_obs <- new_sys_obs + old_sys_obs
diff <- new_sys_mean - old_sys_mean
const_sd <- sqrt(((new_sys_obs-1)*new_sys_sd^2 + (old_sys_obs-1)*old_sys_sd^2)/(total_obs-2))
CI <- diff + c(-1, 1) * qt(1-alpha/2, total_obs-2) * const_sd * sqrt((1/new_sys_obs + 1/old_sys_obs))
print(round(CI,2))


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


n_1 <- 9
n_2 <- 9
mean_1 <- -3
mean_2 <- 1 
sd_1 <- 1.5 
sd_2 <- 1.8 
cons_sd <- sqrt(((n_1-1) * sd_1^2 + (n_2-1) * sd_2^2)/(n_1 + n_2 - 2))
CI <- mean_1 - mean_2 + c(-1, 1) * qt(0.95, n_1+n_2-2) * cons_sd* sqrt(1/n_1 + 1/n_2)
print(round(CI,2))
























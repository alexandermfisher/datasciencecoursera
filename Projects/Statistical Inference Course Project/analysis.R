# analysis.R:

# set seed for reproducability:
set.seed(1)

# generating simulated data:
n_obs <- 40      #number of observations (i.e. per simulation)
n_sim <- 1000     # number of simulations
lambda <- 0.2    # rate paramater lambda
simulated_exponentials <- replicate(n_sim, rexp(n_obs, lambda))
simulated_means <- apply(simulated_exponentials, MARGIN = 2, FUN = mean)

# calculating sample mean and theoretical mean:
theoretical_mean <- 1/lambda
sample_mean <- mean(simulated_means)

# plot simulated data and means.
library(ggplot2)
plot <- ggplot(data = data.frame(simulated_means), aes(x = simulated_means)) + 
                geom_histogram(col = "white", fill = "cornflowerblue", binwidth = 0.2, size = 0.1) +
                scale_x_continuous(breaks = scales::pretty_breaks(n = 5)) +
                geom_vline(aes(xintercept = theoretical_mean), color = "darkred", linetype="solid", size=1.5) +
                geom_vline(aes(xintercept = sample_mean), color = "yellow", linetype="dotted", size=1.5) +
                labs(title = "Distribution of 1000 averages of 40 random exponentials", x = "Mean", y = "Frequency") + 
                theme(plot.title = element_text(hjust = 0.5),text = element_text(size=10)) +
                theme_bw()
#print(plot)

# calculating sd/variances for distribution of averages:
theoretical_sd <- (1/lambda)/sqrt(n_obs); theoretical_sd
sample_sd <- sd(simulated_means); sample_sd
theoretical_var <- theoretical_sd^2; theoretical_var 
sample_var <- sample_sd^2 ; sample_var

plot <- ggplot(data = data.frame(simulated_means), aes(x = simulated_means)) + 
                geom_histogram(aes(y=..density..),col = "white", fill = "cornflowerblue", binwidth = 0.2, size = 0.1) +
                stat_function(fun = dnorm, args = list(mean = theoretical_mean, sd = theoretical_sd),color = "darkred", size = 1) +
                labs(title = "Density Plot with Theoretical Normal Cuvre Overlay", x = "Mean", y = "Frequency") + 
                theme(plot.title = element_text(hjust = 0.5),text = element_text(size=10)) +
                theme_bw()
#print(plot)
        


# ----------------------------------------------------------------------------#

### PART2 - 2:

data("ToothGrowth")
data <- ToothGrowth
head(data,6)
data$dose <- as.factor(data$dose)
str(data)

plot <- qplot(data=data, supp,len, facets=~dose,main="ToothGrowth Data Plot (by supplement type and dosage)",
        xlab="Type of Supplement", ylab="Tooth Length") +
        geom_boxplot(aes(fill = supp))
print(plot)

## HYPOTHESIS TESTING

OJ <- data[data$supp == "OJ", "len"]
VC <- data[data$supp == "VC", "len"]
test_1 <- t.test(x = OJ, y = VC, alternative = "greater" , paired = FALSE, var.equal = FALSE, conf.level = 0.95)
#print(test_1$p.value)


OJ <- data[data$supp == "OJ" & data$dose == "0.5", "len"]
VC <- data[data$supp == "VC" & data$dose == "0.5", "len"]
test_2 <- t.test(x = OJ, y = VC, alternative = "greater" , paired = FALSE, var.equal = FALSE, conf.level = 0.95)
#print(test_2$p.value)

OJ <- data[data$supp == "OJ" & data$dose == "1", "len"]
VC <- data[data$supp == "VC" & data$dose == "1", "len"]
test_3 <- t.test(x = OJ, y = VC, alternative = "greater" , paired = FALSE, var.equal = FALSE)
print(test_3)

OJ_2 <- data[data$supp == "OJ" & data$dose == "2", "len"]
OJ_1 <- data[data$supp == "OJ" & data$dose == "1", "len"]
test_4 <- t.test(x = OJ_2, y = OJ_1, alternative = "greater" , paired = FALSE, var.equal = FALSE)
print(test_4)



















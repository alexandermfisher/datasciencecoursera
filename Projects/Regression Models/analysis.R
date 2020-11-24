# analysis on mtcars:

data("mtcars")
data <- mtcars
data$am <- factor(data$am, labels = c("auto","manual"))
data$cyl <- factor(data$cyl)
print(str(data))
#data$disp_group <- cut(data$disp,breaks = 5)

library(ggplot2)
box_plot <- ggplot(data = data, aes(x = am, y = mpg)) +
                geom_boxplot(aes(colour = am))
print(box_plot)

scatter_plot <- ggplot(data = data, aes(x = cyl, y = mpg)) +
                geom_point(aes(col = am))
                #facet_wrap(~factor(am))
print(scatter_plot)

plot(data[,c("mpg","cyl","wt","disp","am")])


## plot with model plotted over scatter plot
fit_1 <- lm(mpg~as.numeric(cyl)+am, data = data)
plot <- scatter_plot + geom_abline(col = "red", intercept = coef(fit_1)[1], slope = coef(fit_1)[2]) +
                geom_abline(col = "green", intercept = coef(fit_1)[1]+coef(fit_1)[3], slope = coef(fit_1)[2])
print(plot)

best_fit <- step(lm(mpg~., data = data))














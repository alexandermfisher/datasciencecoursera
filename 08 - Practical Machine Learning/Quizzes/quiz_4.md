#### Practical Machine Learning Quiz 4:
*Author: Alexander M Fisher*

**********

##### Question 1:

Load the vowel.train and vowel.test data sets:

Set the variable y to be a factor variable in both the training and test set. Then set the seed to 33833. Fit (1) a random forest predictor relating the factor variable y to the remaining variables and (2) a boosted predictor using the "gbm" method. Fit these both with the train() command in the caret package.

What are the accuracies for the two approaches on the test data set? What is the accuracy among the test set samples where the two methods agree?

###### Answer:

```r
library(AppliedPredictiveModeling)
library(caret)
library(pgmm) 
library(rpart)
library(gbm)
library(lubridate)
library(forecast)
library(e1071)
library(readr)

vowel.train <- read_csv("https://web.stanford.edu/~hastie/ElemStatLearn/datasets/vowel.train")
vowel.test <- read_csv("https://web.stanford.edu/~hastie/ElemStatLearn/datasets/vowel.test")

vowel.train <- vowel.train[,-1]
vowel.test <- vowel.test[,-1]
vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

set.seed(33833)
model_rf <- train(y~., method="rf", vowel.train)
model_boost <- train(y~., method="gbm", vowel.train,verbose=FALSE)
predict_rf <- predict(model_rf, vowel.test)
predict_boost <- predict(model_boost, vowel.test)

confusion_boost <- confusionMatrix(predict_boost, vowel.test$y)
confusion_rf <- confusionMatrix(predict_rf, vowel.test$y)
confusion_boost <- confusionMatrix(predict_boost,vowel.test$y)

print(confusion_rf$overall[['Accuracy']])
print(confusion_boost$overall[['Accuracy']])
print(confusionMatrix(predict_rf,predict_boost)$overall[['Accuracy']])
```
```r
[1] 0.5887446
[1] 0.512987
[1] 0.6969697
```

(By approximation this is most similar result.)

RF Accuracy = 0.6082
GBM Accuracy = 0.5152
Agreement Accuracy = 0.6361

**********

##### Question 2:

Load the Alzheimer's data using the following commands

```r
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```

Set the seed to 62433 and predict diagnosis with all the other variables using a random forest ("rf"), boosted trees ("gbm") and linear discriminant analysis ("lda") model. Stack the predictions together using random forests ("rf"). What is the resulting accuracy on the test set? Is it better or worse than each of the individual predictions?

- Stacked Accuracy: 0.80 is better than random forests and lda and the same as boosting.
- Stacked Accuracy: 0.80 is better than all three other methods
- Stacked Accuracy: 0.76 is better than lda but not random forests or boosting.
- Stacked Accuracy: 0.69 is better than all three other methods

###### Answer:

```r
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)
model_rf <- train(diagnosis~., method="rf", data = training)
model_gbm <- train(diagnosis~., method="gbm", data = training,verbose=FALSE)
model_lda <- train(diagnosis~., method="lda", data = training)

predict_rf<-predict(model_rf,newdata=testing)
predict_gbm<-predict(model_gbm,newdata=testing)
predict_lda<-predict(model_lda,newdata=testing)
print(confusionMatrix(predict_rf, testing$diagnosis)$overall[['Accuracy']])
print(confusionMatrix(predict_gbm, testing$diagnosis)$overall[['Accuracy']])
print(confusionMatrix(predict_lda, testing$diagnosis)$overall[['Accuracy']])

pred_df <- data.frame(predict_rf, predict_gbm, predict_lda, diagnosis = testing$diagnosis)
comb_model <- train(diagnosis ~.,method="rf",data=pred_df)
comb_predict <- predict(comb_model, pred_df)
print(confusionMatrix(comb_predict, testing$diagnosis)$overall[['Accuracy']])
```
```r
[1] 0.7926829           #rf
[1] 0.7804878           #gbm
[1] 0.7682927           #lda
[1] 0.804878            #combined
```

Stacked Accuracy: 0.80 is better than all three other methods

**********

##### Question 3:

Load the concrete data with the commands:

```r
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
```

Set the seed to 233 and fit a lasso model to predict Compressive Strength. Which variable is the last coefficient to be set to zero as the penalty increases? (Hint: it may be useful to look up ?plot.enet).

- Cement
- CoarseAggregate
- Age
- Water

###### Answer:

```r
set.seed(233)
model <- train(CompressiveStrength ~ ., method="lasso", data=training)
library(elasticnet)
plot.enet(model$finalModel, xvar = "penalty", use.color = TRUE)
```
Cement

**********

##### Question 4:

Load the data on the number of visitors to the instructors blog from here:

[https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv](https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv)

Using the commands:

```r
library(lubridate) # For year() function below
dat = read.csv("~/Desktop/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)
```

Fit a model using the bats() function in the forecast package to the training time series. Then forecast this model for the remaining time points. For how many of the testing points is the true value within the 95% prediction interval bounds?

- 94%
- 100%
- 96%
- 92%

###### Answer:

```r
library(lubridate) 
dat = read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

library(forecast)
model <- bats(tstrain)
forecast <- forecast(model, level = 95, h = dim(testing)[1])
sum(forecast$lower < testing$visitsTumblr & testing$visitsTumblr < forecast$upper)/dim(testing)[1]
```
```r
[1] 0.9617021
```
96%

**********

##### Question 5:

Load the concrete data with the commands:

```r
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]
```

Set the seed to 325 and fit a support vector machine using the e1071 package to predict Compressive Strength using the default settings. Predict on the testing set. What is the RMSE?

- 11543.39
- 107.44
- 6.93
- 6.72

###### Answer:

```r
set.seed(325)
model <- svm(CompressiveStrength~., data=training)
predict <- predict(model, testing)
accuracy(predict, testing$CompressiveStrength)
```
```r
##                 ME     RMSE      MAE       MPE     MAPE
## Test set 0.1682863 6.715009 5.120835 -7.102348 19.27739
```

RMSE: 6.72

**********
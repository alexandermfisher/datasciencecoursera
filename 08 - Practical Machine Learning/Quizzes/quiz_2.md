#### Practical Machine Learning Quiz 2:
*Author: Alexander M Fisher*

**********

##### Question 1:

Load the Alzheimer's disease data using the commands:

```r
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
```

Which of the following commands will create non-overlapping training and test sets with about 50% of the observations assigned to each?

###### Answer:

```r
adData = data.frame(diagnosis,predictors)
trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]
```

**********

##### Question 2:

Load the cement data using the commands:

```r
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
```

Make a plot of the outcome (CompressiveStrength) versus the index of the samples. Color by each of the variables in the data set (you may find the cut2() function in the Hmisc package useful for turning continuous covariates into factors). What do you notice in these plots?

- There is a non-random pattern in the plot of the outcome versus index that does not appear to be perfectly explained by any predictor suggesting a variable may be missing.
- There is a non-random pattern in the plot of the outcome versus index that is perfectly explained by the Age variable.
- There is a non-random pattern in the plot of the outcome versus index that is perfectly explained by the FlyAsh variable.
- There is a non-random pattern in the plot of the outcome versus index.

###### Answer:

```r
cols <- names(training); cols <- cols[-9] 
par(mfrow = c(3, 3))
sapply(cols, function(col){
        cut <- Hmisc::cut2(training[,col])
        plot(training$CompressiveStrength, col=cut})
```

There is a non-random pattern in the plot of the outcome versus index that does not appear to be perfectly explained by any predictor suggesting a variable may be missing.

**********

##### Question 3:

Load the cement data using the commands:

```r
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
```

Make a histogram and confirm the SuperPlasticizer variable is skewed. Normally you might use the log transform to try to make the data more symmetric. Why would that be a poor choice for this variable?

- The log transform produces negative values which can not be used by some classifiers.
- There are values of zero so when you take the log() transform those values will be -Inf.
- The log transform does not reduce the skewness of the non-zero values of SuperPlasticizer
- The SuperPlasticizer data include negative values so the log transform can not be performed.

###### Answer:

```r
par(mfrow = c(1,2))
hist(training$Superplasticizer, breaks = 30)
hist(log(training$Superplasticizer + 1), breaks = 30)
```

There are values of zero so when you take the log() transform those values will be -Inf

**********

##### Question 4:

Load the Alzheimer's disease data using the commands:

```r
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```

Find all the predictor variables in the training set that begin with IL. Perform principal components on these variables with the preProcess() function from the caret package. Calculate the number of principal components needed to capture 90% of the variance. How many are there?


###### Answer:

```r
preProcess(training[,grep("^IL", colnames(training))], method="pca", thresh=0.9)
```
```r
## Pre-processing:
##  - centered (12)
##  - ignored (0)
##  - principal component signal extraction (12)
##  - scaled (12)
##
## PCA needed 9 components to capture 90 percent of the variance
```

**********

##### Question 5:

Load the Alzheimer's disease data using the commands:

```r
RNGversion("3.0.0")
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
```

Create a training data set consisting of only the predictors with variable names beginning with IL and the diagnosis. Build two predictive models, one using the predictors as they are and one using PCA with principal components explaining 80% of the variance in the predictors. Use method="glm" in the train function.

What is the accuracy of each method in the test set? Which is more accurate?

- Non-PCA Accuracy: 0.65
PCA Accuracy: 0.72
- Non-PCA Accuracy: 0.72
PCA Accuracy: 0.71
- Non-PCA Accuracy: 0.91
PCA Accuracy: 0.93
- Non-PCA Accuracy: 0.72
PCA Accuracy: 0.65



###### Answer:

Non-PCA Accuracy: 0.65
PCA Accuracy: 0.72

```r
new_training <- training[,grep("^IL|diagnosis", names(training))]
new_testing <-testing[,grep("^IL|diagnosis", names(testing))]

model_1 <- train(diagnosis~.,new_training, method = "glm")
predictions <- predict(model_1,new_testing)
confusion_mat <- confusionMatrix(predictions,new_testing$diagnosis)
confusion_mat$overall[1]

pca <- preProcess(new_training, method="pca", thresh=0.8)
training_pca <- predict(pca, new_training)
testing_pca <- predict(pca, new_testing)
model_2 <- train(diagnosis~.,training_pca, method = "glm")
predictions <- predict(model_2,testing_pca)
confusion_mat <- confusionMatrix(predictions,testing_pca$diagnosis)
confusion_mat$overall[1]
```


**********


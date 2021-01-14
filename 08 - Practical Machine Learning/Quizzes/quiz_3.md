#### Practical Machine Learning Quiz 3:
*Author: Alexander M Fisher*

**********

##### Question 1:

Load the cell segmentation data from the AppliedPredictiveModeling package using the commands:

```r
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
```

1. Subset the data to a training set and testing set based on the Case variable in the data set.
2. Set the seed to 125 and fit a CART model with the rpart method using all predictor variables and default caret settings.
3. In the final model what would be the final model prediction for cases with the following variable values:

- a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2
- b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100
- c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100
- d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2


###### Answer:

```r
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
trainIndex = createDataPartition(segmentationOriginal$Case, p = 0.60,list=FALSE)
training = segmentationOriginal[trainIndex,]
testing = segmentationOriginal[-trainIndex,]

set.seed(125)
model <- train(Class ~ ., method = "rpart", data = training)
print(model$finalModel)
```

**********

##### Question 2:

If K is small in a K-fold cross validation is the bias in the estimate of out-of-sample (test set) accuracy smaller or bigger? If K is small is the variance in the estimate of out-of-sample (test set) accuracy smaller or bigger. Is K large or small in leave one out cross validation?

- The bias is smaller and the variance is bigger. Under leave one out cross validation K is equal to one.
- The bias is smaller and the variance is smaller. Under leave one out cross validation K is equal to the sample size.
- The bias is larger and the variance is smaller. Under leave one out cross validation K is equal to the sample size.
- The bias is smaller and the variance is smaller. Under leave one out cross validation K is equal to one.


###### Answer:

The bias is larger and the variance is smaller. Under leave one out cross validation K is equal to the sample size.


**********

##### Question 3:

Load the olive oil data using the commands:

```r
library(pgmm)
data(olive)
olive = olive[,-1]
```

These data contain information on 572 different Italian olive oils from multiple regions in Italy. Fit a classification tree where Area is the outcome variable. Then predict the value of area for the following data frame using the tree command with all defaults

```r
newdata = as.data.frame(t(colMeans(olive)))
```

What is the resulting prediction? Is the resulting prediction strange? Why or why not?

- 0.005291005 0 0.994709 0 0 0 0 0 0. The result is strange because Area is a numeric variable and we should get the average within each leaf.
- 2.783. There is no reason why this result is strange.
- 2.783. It is strange because Area should be a qualitative variable - but tree is reporting the average value of Area as a numeric variable in the leaf predicted for newdata
- 4.59965. There is no reason why the result is strange.

###### Answer:

```r
model <- train(Area ~ ., method = "rpart", data = olive)
print(predict(model, newdata))
```
```r
##      1 
## 2.783282
```

2.783. It is strange because Area should be a qualitative variable - but tree is reporting the average value of Area as a numeric variable in the leaf predicted for newdata

**********

##### Question 4:

Load the South Africa Heart Disease Data and create training and test sets with the following code:

```r
#library(ElemStatLearn)
library(bestglm)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]
```

Then set the seed to 13234 and fit a logistic regression model (method="glm", be sure to specify family="binomial") with Coronary Heart Disease (chd) as the outcome and age at onset, current alcohol consumption, obesity levels, cumulative tabacco, type-A behavior, and low density lipoprotein cholesterol as predictors. Calculate the misclassification rate for your model using this function and a prediction on the "response" scale:

```r
missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
```

What is the misclassification rate on the training set? What is the misclassification rate on the test set?

- Test Set Misclassification: 0.38
Training Set: 0.25
- Test Set Misclassification: 0.32
Training Set: 0.30
- Test Set Misclassification: 0.31
Training Set: 0.27
- Test Set Misclassification: 0.35
Training Set: 0.31

###### Answer:

```r
set.seed(13234)
model <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
               data = trainSA, method = "glm", family = "binomial")
print(missClass(testSA$chd, predict(model, newdata = testSA)))
print(missClass(trainSA$chd, predict(model, newdata = trainSA)))
```
```r
## [1] 0.3116883
## [1] 0.2727273
```

Test Set Misclassification: 0.31
Training Set: 0.27

**********

##### Question 5:

Load the vowel.train and vowel.test data sets:

Calculate the variable importance using the varImp function in the caret package. What is the order of variable importance?

[NOTE: Use randomForest() specifically, not caret, as there's been some issues reported with that approach. 11/6/2016]

- The order of the variables is:
x.2, x.1, x.5, x.8, x.6, x.4, x.3, x.9, x.7,x.10
- The order of the variables is:
x.2, x.1, x.5, x.6, x.8, x.4, x.9, x.3, x.7,x.10
- The order of the variables is:
x.10, x.7, x.9, x.5, x.8, x.4, x.6, x.3, x.1,x.2
- The order of the variables is:
x.1, x.2, x.3, x.8, x.6, x.4, x.5, x.9, x.7,x.10

###### Answer:

x.2, x.1, x.5, x.6, x.8, x.4, x.9, x.3, x.7,x.10

**********

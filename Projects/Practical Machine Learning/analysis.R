# analysis.R:

##### Getting and Cleaning Data:

# results in training set, validation set, and testing set (classe column is replaced with problem_id column at end)

test_data_file <- "pml-testing.csv"
train_data_file <- "pml-training.csv"
test_data_url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
train_data_url <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
if (!file.exists(test_data_file)){
        download.file(test_data_url, destfile=test_data_file, method="curl")
}
if (!file.exists(train_data_file)){
        download.file(train_data_url, destfile=train_data_file, method="curl")
}

training_data <- read.csv("pml-training.csv", na.strings= c("NA","","#DIV/0!"))
testing_data <- read.csv("pml-testing.csv", na.strings= c("NA","","#DIV/0!"))

training <- training_data[, !colMeans(is.na(training_data)) > 0.95]
testing <- testing_data[, !colMeans(is.na(training_data)) > 0.95]
training$classe <- as.factor(training$classe)
training <- training[, -(1:7)]
testing <- testing[, -(1:7)]

set.seed(222)
inTrain <- createDataPartition(training$classe, p=0.7, list=FALSE)
training <- training[inTrain, ]
validation <- training[-inTrain, ]


##### Exploratory Data Analysis:

correlation_matrix <- cor(training[,-ncol(training)])
corrplot::corrplot(correlation_matrix, method = "color" , type = "upper", tl.cex = 0.5, tl.col = "black")

##### Prediction Models:
library(caret)
library(rpart)

# decision tree
model_dt <- rpart(classe~., training)
model_dt$finalModel

predict_dt <- predict(model_dt, validation, type = "class") 
confusion_dt <- confusionMatrix(predict_dt, validation$classe)

# random forrest
control <- trainControl(method = "cv", number = 3, verboseIter=FALSE)
model_rf <- train(classe ~ ., data = training, method = "parRF", trControl = control, ntree = 50, do.trace = TRUE) 
model_rf$finalModel

predict_rf <- predict(model_rf, validation) 
confusion_rf <- confusionMatrix(predict_rf, validation$classe)

# generalised boosted model
control <- trainControl(method = "repeatedcv", number = 3, repeats = 1, verboseIter = FALSE) 
model_gbm <- train(classe ~ ., data = training, method = "gbm", trControl = control, verbose = FALSE)
model_gbm$finalModel

predict_gbm <- predict(model_gbm, validation) 
confusion_gbm <- confusionMatrix(predict_gbm, validation$classe)


### Predicting on Test Set
predict_test <- predict(model_rf, testing)


varImpObj <- varImp(model_rf)
plot(varImpObj, main = "Importance of Top 40 Variables", top = 10)









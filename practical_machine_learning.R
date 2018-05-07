library(caret)
library(tidyverse)
library(glmnet)
library(glmnetUtils)


train_data <- read.csv(file = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", header = T)
test_data <- read.csv(file = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", header = T)


set.seed(325)
trainIndex <- createDataPartition(train_data$classe, p=0.8, list = FALSE, times=1)
sub_train <- train_data[trainIndex, ]
sub_test <- train_data[-trainIndex, ]

scaler <- preProcess(sub_train, method = c('center', 'scale', 'knnImpute'))
sub_train <- predict(scaler, sub_train)

scaler <- preProcess(sub_test, method = c('center', 'scale', 'knnImpute'))
sub_test <- predict(scaler, sub_test)

lrModel <- glmnet(classe ~ .,data = sub_train, family = 'multinomial')
predictions <- predict(lrModel, sub_test, type = 'class', s = 0.01)
predictions <- as.factor(predictions)  
confusionMatrix(predictions, sub_test$classe)$overall['Accuracy']


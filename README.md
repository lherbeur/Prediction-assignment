# Prediction-assignment

# Introduction
The project focuses on predicting the class of activity done based on information gotten from sensors attached to respondents bodies.

# Importing libraries 
<code>
library(caret)
 
library(tidyverse)

library(glmnet)

library(glmnetUtils)

</code>
 
 #  Data split 
 The data was split into 2 (80:20); 80% used for training and 20% for the test. 
 
 train_data <- read.csv(file = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv", header = T)
test_data <- read.csv(file = "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv", header = T)

set.seed(325)
trainIndex <- createDataPartition(train_data$classe, p=0.8, list = FALSE, times=1)
sub_train <- train_data[trainIndex, ]
sub_test <- train_data[-trainIndex, ]


# Preprocessing
Preprocessing was done to getthedata ready for use in the machine learning algorithm. The preprocessing operation was to center and scale the data.

scaler <- preProcess(sub_train, method = c('center', 'scale', 'knnImpute'))
sub_train <- predict(scaler, sub_train)

scaler <- preProcess(sub_test, method = c('center', 'scale', 'knnImpute'))
sub_test <- predict(scaler, sub_test)


# Building the model and running predictions
The model was built using the logistic regression algorithm.

lrModel <- glmnet(classe ~ .,data = sub_train, family = 'multinomial')
predictions <- predict(lrModel, sub_test, type = 'class', s = 0.01)
predictions <- as.factor(predictions)  #wondering y i had to convert it
confusionMatrix(predictions, sub_test$classe)$overall['Accuracy']





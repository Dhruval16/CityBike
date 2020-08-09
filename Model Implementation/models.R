
rm(list =ls())


completeData <-read.csv("NJ_NYC_Dataset.csv")
completeData <- completeData[,-1]

## Forming a new feature with values "High" and "Low" based on column no. of rides
h_demo <- completeData$Total.Rides < median(completeData$Total.Rides)

h_freq = vector(mode="character",length = nrow(completeData))
h_freq[h_demo] = "LOW" 
h_freq[h_demo == FALSE] = "HIGH"

completeData$levels <- h_freq


## Correlation matrix

install.packages("corrplot")
library(corrplot)
corrplot(cor(completeData[,c(3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)],use = "everything",method = c("pearson","kendall","spearman")))  

dev.off();

  
# Factoring data

## Removing gender and no. of rides  
completeData <- completeData[,c(-3,-5)]

completeData[colnames(completeData)] <- lapply(completeData[colnames(completeData)],factor)



trainRows <- sample(nrow(completeData), size = floor(.70*nrow(completeData)), replace = F)

train <- completeData[trainRows,]
test <- completeData[-trainRows,]

## Random Forest

install.packages('randomForest')

library(randomForest)

train$levels <- as.factor(train$levels)
test$levels <- as.factor(test$levels)

fit <- randomForest( levels~., data=train[,c(-1,-2)], importance=TRUE, ntree=100)
importance(fit)
varImpPlot(fit)
Prediction <- predict(fit, test)
table(actual=test$levels,Prediction)


wrong_rf<- (test$levels!=Prediction )
error_rate_rf<-sum(wrong_rf)/length(wrong_rf)
error_rate_rf 


## Normalization 

mmnorm <- function(x,minx,maxx){
  z<-((x-minx)/(maxx-minx))
}
  
# Normalizing data and removing non-important features for calculating  

Data_normalized <- as.data.frame(
  cbind(Temp_Max = mmnorm(completeData$Temp_Max,min(completeData$Temp_Max),max(completeData$Temp_Max))
        ,Temp_Avg = mmnorm(completeData$Temp_Avg,min(completeData$Temp_Avg),max(completeData$Temp_Avg))
        ,Hum_Max = mmnorm(completeData$Hum_Max,min(completeData$Hum_Max),max(completeData$Hum_Max))
        ,Temp_Min = mmnorm(completeData$Temp_Min,min(completeData$Temp_Min),max(completeData$Temp_Min))
        ,Dew_Max = mmnorm(completeData$Dew_Max,min(completeData$Dew_Max),max(completeData$Dew_Max))
        ,Hum_Avg = mmnorm(completeData$Hum_Avg,min(completeData$Hum_Avg),max(completeData$Hum_Avg))
        ,Hum_Min = mmnorm(completeData$Hum_Min,min(completeData$Hum_Min),max(completeData$Hum_Min))
        ,Levels = factor(completeData$levels)
))

# Factoring normalized data

Data_normalized[colnames(Data_normalized)] <- lapply(Data_normalized[colnames(Data_normalized)],factor)

# Now Selecting 70% of data as sample from total 'n' rows of the data

trainRows <- sample(nrow(Data_normalized), size = floor(.70*nrow(Data_normalized)), replace = F)

train <- Data_normalized[trainRows,]
test <- Data_normalized[-trainRows,]

## K Nearest Neighbour

install.packages("kknn")
library(kknn)

set.seed(117) # Setting the Seed so that same sample can be reporduced

predict_kknn_3 <- kknn(formula = Levels~.,train,test[,-8],k=3,kernel = "rectangular")
fit <- fitted(predict_kknn_3)
table(test$Levels,fit)

kknn_wrong <- sum(test$Levels != fit)
error_rate = kknn_wrong/length(test$Levels)
error_rate

## Naive Bayes

install.packages('e1071')
install.packages('class')
library(e1071)
library(class)

naive_1 <- naiveBayes(Levels~.,data=train)
pred <- predict(naive_1,test[,-8])

table(NBayes=pred,data=test$Levels)

NB_error <- sum(test$Levels!=pred)/length(test$Levels)
NB_error

# CART implementation

install.packages('rpart')
install.packages('rpart.plot')
library(rpart)
library(rpart.plot)

CART_class <- rpart(Levels~.,data= train)
rpart.plot(CART_class)

CART_predict <- predict(CART_class,test[,-8],type = "class")
str(CART_predict)

table(Actual = test[,8],CART=CART_predict)

CART_wrong <- sum(test[,8]!=CART_predict)
error_rate = CART_wrong/length(test$Levels)
error_rate

# C-5.0 Implementation

install.packages('C50')
library('C50')

C50_class <- C5.0( Levels~.,data=train)
summary(C50_class )
plot(C50_class)

C50_predict<-predict( C50_class ,test[,-8] , type="class" )
wrong<- (test[,8]!=C50_predict)

table(actual=test[,8],C50=C50_predict)

c50_rate<-sum(wrong)/length(test[,8])
c50_rate




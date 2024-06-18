#Loading Dataset iris
data("iris")
head(iris)
tail(iris)
#Summary of  Dataset
summary(iris)
#Stucture of Dataset
str(iris)

#Data Visualization with ggplot2
library(ggplot2)
#Pairs Plot
pairs(iris[, 1:4], main = "Iris Data", pch = 21, bg = c("green", "orange", "blue")[unclass(iris$Species)])

#ScatterPlot
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + geom_point() + labs(title = "Sepal Length vs Sepal Width")

#Boxplot
ggplot(iris, aes(x = Species, y = Sepal.Length, fill = Species)) + geom_boxplot() + labs(title = "Boxplot of Sepal Length by Species")


# Data PreProcessing
sum(is.na(iris))

normalize <- function(x) {return ((x - min(x)) / (max(x) - min(x)))}

iris_normalized <- as.data.frame(lapply(iris[, 1:4], normalize))

iris_normalized$Species<- iris$Species

head(iris_normalized)


#Train-Test Split
library(caret)

set.seed(123)

trainIN<- createDataPartition(iris$Species, p=0.8, list= FALSE , times = 1)

Trainiris<- iris[trainIN,]
Testiris <- iris[trainIN,]


# Model Building
library(rpart)

#Model Trained by Decision Tree
modelo <- rpart( Species ~ . ,data = Trainiris , method =  'class')

# Plotting Decision Tree
plot(modelo)
text(modelo, use.n =TRUE)

# Evaluating The Model
prediction <- predict(modelo, Testiris, type='class')

confusionMatrix(prediction, Testiris$Species)

print(modelo)

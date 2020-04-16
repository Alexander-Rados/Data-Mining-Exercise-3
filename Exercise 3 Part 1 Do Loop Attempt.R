library(tidyverse)
library(lubridate)
library(randomForest)
library(pdp)
library(foreach)
library(doMC)
library(mosaic)
options('mosaic:parallelMessage' = FALSE)

# Creating a general green certification for those with LEED or Energystar
# greenbuildings = mutate(greenbuildings, total_rent = Rent*leasing_rate)

greenbuildings = read.csv("~/Documents/Data Mining/data/greenbuildings.csv", header=TRUE)

#####
# Model building for the Random Forest
#####

# Train/Test splits
# training and testing sets
n = nrow(greenbuildings)
n_train = floor(0.8*n)
n_test = n - n_train

greenbuildings_train = greenbuildings[train_cases,]
greenbuildings_test = greenbuildings[-train_cases,]

y_all = greenbuildings$Rent

# stories, elect_costs, size, gas_costs, age all very important
x_all = model.matrix(~age + green_rating + size, data=greenbuildings)

y_train = y_all[train_cases]
x_train = x_all[train_cases,]

y_test = y_all[-train_cases]
x_test = x_all[-train_cases,]

# Fit the model with default parameter settings
forest1 = randomForest(x=x_train, y=y_train, xtest=x_test)
yhat_test = (forest1$test)$predicted

# Plotting out the fits of the guesses to the testing dataset
# plot(yhat_test, y_test)

# RMSE
(yhat_test - y_test)^2 %>% mean %>% sqrt

out_forest1 = do(100)*{
  train_cases = sample.int(n, size=n_train, replace=FALSE)

  greenbuildings_train = greenbuildings[train_cases,]
  greenbuildings_test = greenbuildings[-train_cases,]
  
  y_all = greenbuildings$Rent
  
  # stories, elect_costs, size, gas_costs, age all very important
  x_all = model.matrix(~age + class_a + class_b + green_rating + 
                         stories + renovated + total_dd_07 + 
                         Precipitation + Electricity_Costs + Gas_Costs + 
                         size, data=greenbuildings)
  
  y_train = y_all[train_cases]
  x_train = x_all[train_cases,]
  
  y_test = y_all[-train_cases]
  x_test = x_all[-train_cases,]
  
  # Fit the model with default parameter settings
  forest1 = randomForest(x=x_train, y=y_train, xtest=x_test)
  yhat_test = (forest1$test)$predicted

  # RMSE
  (yhat_test - y_test)^2 %>% mean %>% sqrt
}
mean(out_forest1$result)
varImpPlot(forest1)



rm(list=ls())

##install.packages('readr')

library(readr)

##### JERSEY CITY #####

##files <- c('JC-201810.csv','JC-201811.csv','JC-201812.csv','JC-201909.csv','JC-201908.csv','JC-201907.csv','JC-201906.csv','JC-201905.csv','JC-201904.csv','JC-201903.csv','JC-201902.csv','JC-201901.csv')

files <- c('jersey-JC-201810.csv','jersey-JC-201811.csv','jersey-JC-201812.csv','jersey-JC-201909.csv','jersey-JC-201908.csv','jersey-JC-201907.csv','jersey-JC-201906.csv','jersey-JC-201905.csv','jersey-JC-201904.csv','jersey-JC-201903.csv','jersey-JC-201902.csv','jersey-JC-201901.csv')

NJBike <- data.frame();

for(month in files){
  trip <- read_csv(month);
  NJBike <- rbind(NJBike,trip);
}

NJBike <- NJBike[,-1]
##weather <- read.csv('weather-jc-prac1.csv')
weather <- read.csv('weather-jc.csv')



weather$Date <- as.character(weather$Date)
NJBike$Date <- as.character(NJBike$Date)

NJBike <- merge(NJBike, weather, by="Date", all=TRUE)

write.csv(NJBike,file = "JC-merged.csv")





##### Up-town Newyork #####

## Up-town files <- c('newyork-nyc-201810.csv','newyork-nyc-201811.csv','newyork-nyc-201812.csv','newyork-nyc-201909.csv','newyork-nyc-201908.csv','newyork-nyc-201907.csv','newyork-nyc-201906.csv','newyork-nyc-201905.csv','newyork-nyc-201904.csv','newyork-nyc-201903.csv','newyork-nyc-201902.csv','newyork-nyc-201901.csv')

files <- c('up-nyc-201810.csv','up-nyc-201811.csv','up-nyc-201812.csv','up-nyc-201909.csv','up-nyc-201908.csv','up-nyc-201907.csv','up-nyc-201906.csv','up-nyc-201905.csv','up-nyc-201904.csv','up-nyc-201903.csv','up-nyc-201902.csv','up-nyc-201901.csv')

NJBike <- data.frame();

for(month in files){
  trip <- read_csv(month);
  NJBike <- rbind(NJBike,trip);
}

NJBike <- NJBike[,-1]
##weather <- read.csv('weather-jc-prac1.csv')
weather <- read.csv('weather-nyc.csv')



weather$Date <- as.character(weather$Date)
NJBike$Date <- as.character(NJBike$Date)

NJBike <- merge(NJBike, weather, by="Date", all=TRUE)

write.csv(NJBike,file = "up.nyc-merged.csv")


##### Low - NYC #####

## Low-town files <- c('low-nyc-201810.csv','low-nyc-201811.csv','low-nyc-201812.csv','low-nyc-201909.csv','low-nyc-201908.csv','low-nyc-201907.csv','low-nyc-201906.csv','low-nyc-201905.csv','low-nyc-201904.csv','low-nyc-201903.csv','low-nyc-201902.csv','low-nyc-201901.csv')

files <- c('low-nyc-201810.csv','low-nyc-201811.csv','low-nyc-201812.csv','low-nyc-201909.csv','low-nyc-201908.csv','low-nyc-201907.csv','low-nyc-201906.csv','low-nyc-201905.csv','low-nyc-201904.csv','low-nyc-201903.csv','low-nyc-201902.csv','low-nyc-201901.csv')

NJBike <- data.frame();

for(month in files){
  trip <- read_csv(month);
  NJBike <- rbind(NJBike,trip);
}

NJBike <- NJBike[,-1]
##weather <- read.csv('weather-jc-prac1.csv')
weather <- read.csv('weather-nyc.csv')



weather$Date <- as.character(weather$Date)
NJBike$Date <- as.character(NJBike$Date)

NJBike <- merge(NJBike, weather, by="Date", all=TRUE)

write.csv(NJBike,file = "low.nyc-merged.csv")

##### Mid - NYC #####

## Mid-town files <- c('mid-nyc-201810.csv','mid-nyc-201811.csv','mid-nyc-201812.csv','mid-nyc-201909.csv','mid-nyc-201908.csv','mid-nyc-201907.csv','mid-nyc-201906.csv','mid-nyc-201905.csv','mid-nyc-201904.csv','mid-nyc-201903.csv','mid-nyc-201902.csv','mid-nyc-201901.csv')

files <- c('mid-nyc-201810.csv','mid-nyc-201811.csv','mid-nyc-201812.csv','mid-nyc-201909.csv','mid-nyc-201908.csv','mid-nyc-201907.csv','mid-nyc-201906.csv','mid-nyc-201905.csv','mid-nyc-201904.csv','mid-nyc-201903.csv','mid-nyc-201902.csv','mid-nyc-201901.csv')

NJBike <- data.frame();

for(month in files){
  trip <- read_csv(month);
  NJBike <- rbind(NJBike,trip);
}

NJBike <- NJBike[,-1]
##weather <- read.csv('weather-jc-prac1.csv')
weather <- read.csv('weather-nyc.csv')



weather$Date <- as.character(weather$Date)
NJBike$Date <- as.character(NJBike$Date)

NJBike <- merge(NJBike, weather, by="Date", all=TRUE)

write.csv(NJBike,file = "mid.nyc-merged.csv")

##### bnq - NYC #####

## bnq-town files <- c('bnq-nyc-201810.csv','bnq-nyc-201811.csv','bnq-nyc-201812.csv','bnq-nyc-201909.csv','bnq-nyc-201908.csv','bnq-nyc-201907.csv','bnq-nyc-201906.csv','bnq-nyc-201905.csv','bnq-nyc-201904.csv','bnq-nyc-201903.csv','bnq-nyc-201902.csv','bnq-nyc-201901.csv')

files <- c('bnq-nyc-201810.csv','bnq-nyc-201811.csv','bnq-nyc-201812.csv','bnq-nyc-201909.csv','bnq-nyc-201908.csv','bnq-nyc-201907.csv','bnq-nyc-201906.csv','bnq-nyc-201905.csv','bnq-nyc-201904.csv','bnq-nyc-201903.csv','bnq-nyc-201902.csv','bnq-nyc-201901.csv')

NJBike <- data.frame();

for(month in files){
  trip <- read_csv(month);
  NJBike <- rbind(NJBike,trip);
}

NJBike <- NJBike[,-1]
##weather <- read.csv('weather-jc-prac1.csv')
weather <- read.csv('weather-nyc.csv')



weather$Date <- as.character(weather$Date)
NJBike$Date <- as.character(NJBike$Date)

NJBike <- merge(NJBike, weather, by="Date", all=TRUE)

write.csv(NJBike,file = "bnq.nyc-merged.csv")




##### Main Dataset #####

files <- c('JC-merged.csv','low.nyc-merged.csv','mid.nyc-merged.csv','up.nyc-merged.csv','bnq.nyc-merged.csv')

NJBike <- data.frame();

for(month in files){
  trip <- read_csv(month);
  NJBike <- rbind(NJBike,trip);
}

NJBike <- NJBike[,-1]

write.csv(NJBike,file = "NJ_NYC_Dataset.csv")


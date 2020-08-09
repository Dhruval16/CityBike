##install.packages('readr')
library(readr)

#### JERSEY CITY


files <- c('JC-201811.csv','JC-201812.csv','JC-201810.csv','JC-201909.csv','JC-201908.csv','JC-201907.csv','JC-201906.csv','JC-201905.csv','JC-201904.csv','JC-201903.csv','JC-201902.csv','JC-201901.csv')

lat_JC <- c(40.742128,40.782185,40.720629,40.687902)
long_JC <- c(-74.008209,-74.058597,-74.100906,-74.049799)
lat_JC <- lat_JC*100000
long_JC <- long_JC*100000
## 1) 14th Street and 10th Ave
## 2) Seacaucus
## 3) Lincoln Park
## 4) Ellis island


final <- function(month,latitude,longitude,tripdata){
  
  ## function 1
  trips_In_Region  <-function(latitude,longitude,tripdata){
    lat_data <- tripdata[,6]*100000;
    long_data <- tripdata[,7]*100000;
    long_data <- long_data[,1]
    lat_data <- lat_data[,1]
    
    ##install.packages('sp')
    library(sp)
    
    typeof(tripdata[,6])
    class(tripdata[,6])
    
    ## rows belonging to this region
    region_rows <- point.in.polygon(lat_data,long_data, latitude, longitude, mode.checked=FALSE)
    region_rows<-data.frame(region_rows)
    
    ## data belonging to region
    data_region <- tripdata[region_rows$region_rows == 1,]
    
    ## number of rows
    sum(region_rows)
    
    return (data_region)
  }
  
  data_reg <- trips_In_Region(latitude,longitude,tripdata)
  
  ###################################################################################
  ###################################################################################
  
  ## Now we will find the number of rides for each day in a region
  ##install.packages('stringr')
  ##install.packages('dplyr')
  library(stringr)
  library(dplyr)
  
  
  x<-split(data_reg,data_reg$`start station name`);
  
  ## load this function
  station_rides <- function(m){
    ## m is individiual station data
    
    ## Task 1:  removing time
    ## typeof(m$starttime)
    
    m$starttime<-as.character(m$starttime)
    m$starttime<-substr(m$starttime, 1, 10)
    
    ## finding number of rows -> 30 or 31 (also 28)
    ## unique(m$starttime)
    
    ## demand variable is the number of rides per day
    demand<-data.frame(summary.factor(m$starttime))
    
    ## tidying up data
    ## adding "Date" Column
    df <- tibble::rownames_to_column(demand, "Date")
    ## adding station name to the data frame
    df <-cbind(`Station` =(m$`start station name`)[1], df)
    ## renaming coloumn 3 to "Total Rides"
    df <- df %>% rename(`Total Rides` =summary.factor.m.starttime.)
    ## adding usertype to the data frame
    df <- cbind(`Usertype` = (m$`usertype`)[1],df)
    ## adding Gender to the data frame
    df <- cbind(`Gender` = (m$`gender`)[1],df)
    ## swapping coloumns  
    df <- df[, c("Date", "Station", "Total Rides","Usertype","Gender")]
    
    return(df)
  }
  
  ## list of station data for the given month
  op <- lapply(x,station_rides)
  
  regional_station_data <- data.frame()
  sum <- 0
  for(lis in op){
    sum <- sum + nrow(lis)
    regional_station_data <- rbind(regional_station_data,lis);
  }
  summary(regional_station_data$`Total Rides`)
  
  ####
  write.csv(regional_station_data,paste0("jersey-",month))
}

for(month in files){
  trip <- read_csv(month);
  
  final(month,lat_JC,long_JC,trip)
  rm(trip)
}

##install.packages('readr')
library(readr)

#### midtown NYC

files <- c('nyc-201811.csv','nyc-201812.csv','nyc-201810.csv','nyc-201909.csv','nyc-201908.csv','nyc-201907.csv','nyc-201906.csv','nyc-201905.csv','nyc-201904.csv','nyc-201903.csv','nyc-201902.csv','nyc-201901.csv')
lat_low <- c(40.88201145,  40.87146853, 40.83567808, 40.81057181, 40.78935494, 40.80811789)
long_low <- c(-73.93323407, -73.90743256,  -73.93291321, -73.93266644, -73.92825555, -73.97766083)
lat_low <- lat_low*100000
long_low <- long_low*100000


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
    
    ## demand variable is the number of reides per day
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
  write.csv(regional_station_data,paste0("up-",month))
}

for(month in files){
  trip <- read_csv(month);
  
  final(month,lat_low,long_low,trip)
  rm(trip)
}

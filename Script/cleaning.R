library(tidyverse)
library(lubridate)

price_data <- read.csv("~/Cocoa_price_preditcion/Data/Origion_data/Daily_Prices_ICCO.csv")
climate_data <- read.csv("~/Cocoa_price_preditcion/Data/Origion_data/Ghana_data.csv")
dollar <- read.csv("~/Cocoa_price_preditcion/Data/Origion_data/US_Dollar_index_from2006.csv")

price <- price_data %>%
  rename(
    Date = Date,
    Price = `ICCO.daily.price..US..tonne.`
  ) %>%
  mutate(
    Date = dmy(Date),  
    Price = parse_number(Price)  
  )


climate <- climate_data %>%
  mutate(
    DATE = ymd(DATE),  
    PRCP = as.numeric(PRCP),
    TAVG = as.numeric(TAVG),
    TMAX = as.numeric(TMAX),
    TMIN = as.numeric(TMIN)
  )


dollar <- dollar %>%
  mutate(
    Date = ymd(observation_date),
    Dollar_index = as.numeric(DTWEXBGS)
  )
  


write_csv(climate,"~/Cocoa_price_preditcion/Data/Cleaned_data/climate.csv" )
write_csv(price,"~/Cocoa_price_preditcion/Data/Cleaned_data/price.csv" )
write_csv(dollar,"~/Cocoa_price_preditcion/Data/Cleaned_data/dollar_index.csv" )

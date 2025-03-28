price <- read.csv("~/Cocoa_price_preditcion/Data/price.csv")
climate <- read.csv("~/Cocoa_price_preditcion/Data/climate.csv" )

climate %>%
  summarize(
    PRCP_NA = sum(is.na(PRCP))/count(climate_data), # 0.665815 missing %
    TMAX_NA = sum(is.na(TMAX))/count(climate_data), # 0.3450621
    TMIN_NA = sum(is.na(TMIN))/count(climate_data)  # 0.357273
  )

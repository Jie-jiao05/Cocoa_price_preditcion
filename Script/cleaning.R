price_data <- read.csv("~/Cocoa_price_preditcion/Data/Daily_Prices_ICCO.csv")
climate_data <- read.csv("~/Cocoa_price_preditcion/Data/Ghana_data.csv")


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

write_csv(climate,"~/Cocoa_price_preditcion/Data/climate.csv" )
write_csv(price,"~/Cocoa_price_preditcion/Data/price.csv" )
# Load necessary libraries
library(readr)
library(dplyr)
library(tidyr)
library(lubridate)

price_data <- read.csv("~/Cocoa_price_preditcion/Data/Cleaned_data/price.csv")

## transform into monthly avg price

# Convert Date column to Date type
price_data <- price_data %>%
  mutate(Date = as.Date(Date))

# Create a new column for year-month and get the first day of each month
monthly <- price_data %>%
  mutate(Month = floor_date(Date, unit = "month")) %>%
  group_by(Month) %>%
  summarise(Monthly_Avg = mean(Price, na.rm = TRUE)) %>%
  ungroup()

write_csv(monthly, "~/Cocoa_price_preditcion/Data/Cleaned_data/price_monthly.csv")

price <- monthly_climate %>%
  filter(Month >= as.Date("2015-01-01"))

write_csv(price, "~/Cocoa_price_preditcion/Data/Filtered_data/Price.csv")

##################

climate_data <- read.csv("~/Cocoa_price_preditcion/Data/Cleaned_data/climate.csv")


# Ensure DATE and TAVG are properly formatted
climate_data <- climate_data %>%
  mutate(
    DATE = as.Date(DATE),
    TAVG = as.numeric(TAVG)
  ) %>%
  filter(!is.na(TAVG))  # remove rows with missing temperature

# Step 1: Average per day in case of duplicates
daily_avg <- climate_data %>%
  group_by(DATE) %>%
  summarise(Daily_TAVG = mean(TAVG, na.rm = TRUE)) %>%
  ungroup()

# Step 2: Average per month
monthly_climate <- daily_avg %>%
  mutate(Month = floor_date(DATE, "month")) %>%
  group_by(Month) %>%
  summarise(
    Monthly_Avg_Temp = mean(Daily_TAVG),
    Valid_Days = n()
  ) %>%
  ungroup()

write_csv(monthly_climate, "~/Cocoa_price_preditcion/Data/Cleaned_data/climate_monthly.csv")

monthly_climate <- monthly_climate %>%
  filter(Month >= as.Date("2015-01-01"))

write_csv(climate, "~/Cocoa_price_preditcion/Data/Filtered_data/Climate.csv")

#################
macro <- read_csv("~/Cocoa_price_preditcion/Data/Origion_data/Index.csv")

# Step 2: 保留关键列并 wide pivot
macro_wide <- macro %>%
  select(Year, Variable, Value) %>%
  pivot_wider(names_from = Variable, values_from = Value)

# Step 3: 添加 Date 列（设为每年1月）
macro_wide <- macro_wide %>%
  mutate(Date = ymd(paste0(Year, "-01-01"))) %>%
  select(-Year)

# Step 4: 创建完整月度序列
full_months <- tibble(Date = seq(min(macro_wide$Date), max(macro_wide$Date), by = "1 month"))

# Step 5: 合并 & forward fill
macro_monthly <- full_months %>%
  left_join(macro_wide, by = "Date") %>%
  mutate(across(-Date, ~ na.locf(.x, na.rm = FALSE)))  # forward fill 每列


write_csv(macro_monthly, "~/Cocoa_price_preditcion/Data/Cleaned_data/Index_monthly.csv")

macro_monthly <- macro_monthly %>%
  filter(Date >= as.Date("2015-01-01"))

write_csv(macro_monthly, "~/Cocoa_price_preditcion/Data/Filtered_data/Indiex.csv")

################
PRCP <- read_csv("~/Cocoa_price_preditcion/Data/Origion_data/PRCP_monthly.csv")

PRCP_monthly <- PRCP %>%
  mutate(
    date = as.Date(paste0(date, "-01")),  # Convert to Date
    prep = as.numeric(prep)               # Ensure numeric type
  )


write_csv(PRCP_monthly, "~/Cocoa_price_preditcion/Data/Cleaned_data/PRCP_monthly.csv")

PRCP_filtered <- PRCP_monthly %>%
  filter(date >= as.Date("2015-01-01"))

write_csv(PRCP_monthly, "~/Cocoa_price_preditcion/Data/Filtered_data/PRCP.csv")

#####################
Fert<-read_csv("~/Cocoa_price_preditcion/Data/Cleaned_data/Monthly_Fertilizer_Data.csv")

write_csv(Fert, "~/Cocoa_price_preditcion/Data/Filtered_data/Fert.csv")

############
#dollar <- read.csv("~/Cocoa_price_preditcion/Data/Cleaned_data/dollar_index.csv")
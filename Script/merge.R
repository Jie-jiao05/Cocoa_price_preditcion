library(readr)
library(dplyr)
library(tidyr)
library(lubridate)

# Set working directory
setwd("~/Cocoa_price_preditcion/Data/Filtered_data")

# Load datasets
climate <- read.csv("Climate.csv")
fert <- read.csv("Fert.csv")
index <- read.csv("Indiex.csv")
prcp <- read.csv("PRCP.csv")
price <- read.csv("Price.csv")
production <- read.csv("Production.csv")
yield <- read.csv("Yield.csv")

# Standardize time column names to "Date"
colnames(climate)[colnames(climate) == "Month"] <- "Date"
colnames(price)[colnames(price) == "Month"] <- "Date"
colnames(prcp)[tolower(colnames(prcp)) == "date"] <- "Date"

# All others already use "Date" correctly

# Drop ID columns from production (optional)
production <- production[, !(colnames(production) %in% c("Entity", "Code"))]

# Check all have a "Date" column
dfs <- list(climate, fert, index, prcp, price, production, yield)
stopifnot(all(sapply(dfs, function(df) "Date" %in% colnames(df))))

# Merge all on "Date"
merged_data <- Reduce(function(x, y) merge(x, y, by = "Date", all = TRUE), dfs)

# Convert Date to proper Date format if it's YYYY-MM or YYYY-MM-DD
merged_data$Date <- as.Date(paste0(merged_data$Date, "-01"))  # adjust if needed


merged_data <- merged_data[order(merged_data$Date), ]

merged_data <- merged_data[, !colnames(merged_data) %in% "Valid_Days"]

write_csv(merged_data,"~/Cocoa_price_preditcion/Data/Model_data/model.csv" )


#head(merged_data)

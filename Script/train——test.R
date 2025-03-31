set.seed(522)  # for reproducibility

merged_data<- read_csv("~/Cocoa_price_preditcion/Data/Model_data/model.csv")

# Total number of rows
n <- nrow(merged_data)

# Randomly sample 70% of row indices
train_indices <- sample(1:n, size = floor(0.7 * n), replace = FALSE)

# Split the data
train_data <- merged_data[train_indices, ]
test_data <- merged_data[-train_indices, ]

write_csv(train_data,"~/Cocoa_price_preditcion/Data/Model_data/train.csv" )
write_csv(test_data,"~/Cocoa_price_preditcion/Data/Model_data/test.csv" )

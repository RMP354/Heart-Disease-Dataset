# Load required libraries
library(dplyr)
library(tidyverse)

# Load dataset
heart_data <- read.csv("data-raw/heart.csv")

# Step 1: Identify and handle missing values
# Impute missing values with the median of the respective columns
heart_data <- heart_data %>%
  mutate(across(everything(), ~ ifelse(is.na(.), median(., na.rm = TRUE), .)))

# Step 2: Convert categorical variables to factors with meaningful labels
heart_data <- heart_data %>%
  mutate(
    target = factor(target, levels = c(0, 1), labels = c("No Heart Disease", "Heart Disease")),
    sex = factor(sex, levels = c(0, 1), labels = c("Female", "Male")),
    cp = factor(cp, levels = c(0, 1, 2, 3), labels = c("Typical Angina", "Atypical Angina", "Non-anginal Pain", "Asymptomatic")),
    fbs = factor(fbs, levels = c(0, 1), labels = c("≤ 120 mg/dl", "> 120 mg/dl")),
    exang = factor(exang, levels = c(0, 1), labels = c("No", "Yes")),
    thal = factor(thal, levels = c(1, 2, 3), labels = c("Normal", "Fixed Defect", "Reversible Defect"))
  )

# Step 3: Standardize column names to improve readability
colnames(heart_data) <- gsub(" ", "_", tolower(colnames(heart_data)))

# View the cleaned data
summary(heart_data)

# Save the data frame to the data/ directory as MaxTemp.rda
usethis::use_data(heart_data)


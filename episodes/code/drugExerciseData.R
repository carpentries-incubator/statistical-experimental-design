# Load required packages
library(tidyverse)


# Set seed for reproducibility
set.seed(123)

# Define factor levels
drug_dose <- c(0, 5, 10, 20)           # mg/kg
exercise_duration <- c(0, 15, 30, 60)  # minutes/day

# Create a full factorial design
design <- expand.grid(DrugDose = drug_dose,
                      Exercise = exercise_duration)

# Simulate response variable (glucose level) with some interaction
# True model: Glucose = 150 - 2*DrugDose - 0.5*Exercise +
#             0.05*DrugDose*Exercise + random noise
design$Glucose <- 150 - 2 * design$DrugDose - 0.5 * design$Exercise + 
  0.05 * design$DrugDose * design$Exercise +
  rnorm(nrow(design), mean = 0, sd = 5)

# Repeat each combination 5 times (replicates)
data <- design[rep(1:nrow(design), each = 5), ]
data$Glucose <- data$Glucose + rnorm(nrow(data), 0, 3)  # additional noise
data$DrugDose <- as.factor(data$DrugDose)
data$Exercise <- as.factor(data$Exercise)
head(data)

write.csv(data, file = "../data/drugExercise.csv", quote = FALSE)

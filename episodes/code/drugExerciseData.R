# Load required packages
library(tidyverse)


# Set seed for reproducibility
set.seed(123)

# Define factor levels
drug_dose <- c(0, 5, 10, 20)           # mg/kg
exercise_duration <- c(0, 15, 30, 60)  # minutes/day
n_per_group <- 5

# Create a full factorial design
design <- expand.grid(DrugDose = drug_dose,
                      Exercise = exercise_duration)

# Replicate each combination
design <- design[rep(1:nrow(design), each = n_per_group), ]

# Simulate baseline glucose (random between 200 and 300 mg/dL)
design$Baseline <- round(rnorm(nrow(design), mean = 250, sd = 15), 1)

# Simulate treatment effect (fictional, but plausible interaction)
# Stronger effect with higher drug and longer exercise
design$Delta <- with(design, 
                     -0.5 * DrugDose - 0.4 * Exercise/10 + 
                       0.01 * DrugDose * Exercise +
                       rnorm(nrow(design), mean = 0, sd = 5))

# Compute post-treatment glucose
design$Post <- design$Baseline + design$Delta

# Clean up
design$DrugDose <- as.factor(design$DrugDose)
design$Exercise <- as.factor(design$Exercise)

write_csv(design, file = "data/drugExercise.csv")



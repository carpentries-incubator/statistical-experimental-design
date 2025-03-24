# create simulated heart rate data for Generation 100 Study

heart_rate <- tibble(sex            = rep(c("M", "F"), c(777, 790)), 
                     exercise_group = rep(c("control", "moderate intensity", 
                                            "high intensity"),
                                          c(780, 387, 400)),
                     age            = rnorm(1567, mean = 72.8, sd = 1))

heart_rate <- heart_rate %>%
  mutate(heart_rate = case_when(sex == "M" & exercise_group == "high intensity" ~ 
                                  rnorm(n = dim(heart_rate)[1], mean = 60, 
                                        sd = 5),
                                sex == "M" & exercise_group == "moderate intensity" ~ 
                                  rnorm(n = dim(heart_rate)[1], mean = 66, 
                                        sd = 5),
                                sex == "M" & exercise_group == "control" ~  
                                  rnorm(n = dim(heart_rate)[1], mean = 70, 
                                        sd = 5), 
                                sex == "F" & exercise_group == "high intensity" ~ 
                                  rnorm(dim(heart_rate)[1], mean = 63, 
                                        sd = 5), 
                                sex == "F" & exercise_group == "moderate intensity" ~ 
                                  rnorm(dim(heart_rate)[1], mean = 69, 
                                        sd = 5), 
                                sex == "F" & exercise_group == "control" ~ 
                                  rnorm(dim(heart_rate)[1], mean = 73, 
                                        sd = 5)))

write_csv(heart_rate, file = "data/simulated_heart_rates.csv")

---
title: Completely Randomized Design with More than One Treatment Factor
teaching: 0
exercises: 0
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- .
- .

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How is a CRD with more than one treatment factor designed and analyzed?

::::::::::::::::::::::::::::::::::::::::::::::::::

experiment structured by two or more factors that can be qualitative or quantitative. Same design issues - which factors to choose, which levels? A full factorial experiment includes all levels of all factors,
which can become unwieldy when there are many levels for each factor. There are options to use only a fraction of the factor levels. Let's consider full factorial experiment here.





``` r
drugExercise <- read.csv("data/drugExercise.csv")

drugExercise %>% 
  group_by(Exercise, DrugDose) %>% 
  summarise(mean = mean(Glucose))
```

``` error
Error in drugExercise %>% group_by(Exercise, DrugDose) %>% summarise(mean = mean(Glucose)): could not find function "%>%"
```

``` r
drugExercise %>% 
  group_by(DrugDose, Exercise) %>% 
  summarise(mean = mean(Glucose))
```

``` error
Error in drugExercise %>% group_by(DrugDose, Exercise) %>% summarise(mean = mean(Glucose)): could not find function "%>%"
```

``` r
drugExercise %>% 
  ggplot(aes(Exercise, Glucose)) + 
  geom_point(aes(color = DrugDose))
```

``` error
Error in drugExercise %>% ggplot(aes(Exercise, Glucose)): could not find function "%>%"
```

``` r
drugExercise %>% 
  ggplot(aes(DrugDose, Glucose)) + 
  geom_point(aes(color = Exercise))
```

``` error
Error in drugExercise %>% ggplot(aes(DrugDose, Glucose)): could not find function "%>%"
```

``` r
# Interaction plot
interaction.plot(x.factor = data$DrugDose,
                 trace.factor = data$Exercise,
                 response = data$Glucose,
                 fun = mean,
                 col = hcl.colors(4),
                 xlab = "Drug Dose (mg/kg)",
                 ylab = "Mean Blood Glucose (mg/dL)",
                 trace.label = "Exercise Duration (min)")
```

``` error
Error in data$DrugDose: object of type 'closure' is not subsettable
```

If lines were parallel we could assume no interaction. Since they are not 
parallel we should assume interaction between exercise and drug dose.


``` r
anova(lm(Glucose ~ DrugDose + Exercise + DrugDose*Exercise, 
         data = drugExercise))
```

``` output
Analysis of Variance Table

Response: Glucose
                  Df Sum Sq Mean Sq  F value    Pr(>F)    
DrugDose           1 1132.1  1132.1  41.4888 9.717e-09 ***
Exercise           1   47.6    47.6   1.7456    0.1904    
DrugDose:Exercise  1 6465.2  6465.2 236.9247 < 2.2e-16 ***
Residuals         76 2073.9    27.3                       
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

:::::::::::::::::::::::::::::::::::::::: keypoints

- Completely randomized designs can be structured with two or more factors.
- Random assignment of treatments to experimental units in a single homogeneous group is the same.
- Factorial structure of the experiment requires different analyses, primarily
ANOVA.

::::::::::::::::::::::::::::::::::::::::::::::::::



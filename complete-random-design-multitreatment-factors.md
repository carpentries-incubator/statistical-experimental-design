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
drugExercise <- read_csv("data/drugExercise.csv")
drugExercise$DrugDose <- as_factor(drugExercise$DrugDose)
drugExercise$Exercise <- as_factor(drugExercise$Exercise)

drugExercise %>% 
  group_by(Exercise, DrugDose) %>% 
  summarise(mean = mean(Glucose))
```

``` output
# A tibble: 16 × 3
# Groups:   Exercise [4]
   Exercise DrugDose  mean
   <fct>    <fct>    <dbl>
 1 0        0         146.
 2 0        5         136.
 3 0        10        139.
 4 0        20        112.
 5 15       0         143.
 6 15       5         145.
 7 15       10        132.
 8 15       20        113.
 9 30       0         131.
10 30       5         129.
11 30       10        138.
12 30       20        126.
13 60       0         121.
14 60       5         126.
15 60       10        129.
16 60       20        149.
```

``` r
drugExercise %>% 
  group_by(DrugDose, Exercise) %>% 
  summarise(mean = mean(Glucose))
```

``` output
# A tibble: 16 × 3
# Groups:   DrugDose [4]
   DrugDose Exercise  mean
   <fct>    <fct>    <dbl>
 1 0        0         146.
 2 0        15        143.
 3 0        30        131.
 4 0        60        121.
 5 5        0         136.
 6 5        15        145.
 7 5        30        129.
 8 5        60        126.
 9 10       0         139.
10 10       15        132.
11 10       30        138.
12 10       60        129.
13 20       0         112.
14 20       15        113.
15 20       30        126.
16 20       60        149.
```

``` r
drugExercise %>% 
  ggplot(aes(Exercise, Glucose)) + 
  geom_point(aes(color = DrugDose))
```

<img src="fig/complete-random-design-multitreatment-factors-rendered-explore_data-1.png" style="display: block; margin: auto;" />

``` r
drugExercise %>% 
  ggplot(aes(DrugDose, Glucose)) + 
  geom_point(aes(color = Exercise))
```

<img src="fig/complete-random-design-multitreatment-factors-rendered-explore_data-2.png" style="display: block; margin: auto;" />

## Interaction between factors
We could analyze these data as if it were simply a completely randomized design
with 16 treatments (4 drug doses and 4 exercise durations). The ANOVA would have 
15 degrees of freedom for treatments and the F-test would tell us whether the 
variation among average glucose levels for the 16 treatments was real or random.
However, the factorial treatment structure lets us separate out the variability 
in glucose levels among drug doses averaged over exercise durations. The ANOVA table would provide a sum of squares based on 3 degrees of freedom for the difference between the 4 treatment means ($\bar{y}_i$) and the pooled (overall) mean ($\bar{y}$).  

Sum of squares for 16 treatments $= n\sum(\bar{y}_i - \bar{y})^2$. 

The sum of squares would capture the variability among the 4 drug dose levels.
The variation among the 4 exercise levels would be captured similarly, with 3
degrees of freedom. That leaves 15 - 6 = 9 degrees of freedom left over. What 
variability do these remaining 9 degrees of freedom contain? The answer is
interaction - the interaction between drug doses and exercise durations. Mean glucose for each of the 16 treatments is given in the table below.

<table>
 <thead>
<tr>
<th style="empty-cells: hide;border-bottom:hidden;" colspan="2"></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; " colspan="3"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Drug Dose</div></th>
</tr>
  <tr>
   <th style="text-align:left;"> Exercise </th>
   <th style="text-align:right;"> 0 </th>
   <th style="text-align:right;"> 5 </th>
   <th style="text-align:right;"> 10 </th>
   <th style="text-align:right;"> 20 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:right;"> 145.8 </td>
   <td style="text-align:right;"> 136.3 </td>
   <td style="text-align:right;"> 138.7 </td>
   <td style="text-align:right;"> 112.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:right;"> 142.6 </td>
   <td style="text-align:right;"> 145.3 </td>
   <td style="text-align:right;"> 132.4 </td>
   <td style="text-align:right;"> 112.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:right;"> 131.4 </td>
   <td style="text-align:right;"> 128.7 </td>
   <td style="text-align:right;"> 137.9 </td>
   <td style="text-align:right;"> 125.8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:right;"> 121.1 </td>
   <td style="text-align:right;"> 126.0 </td>
   <td style="text-align:right;"> 129.2 </td>
   <td style="text-align:right;"> 149.5 </td>
  </tr>
</tbody>
</table>

We can visualize interactions for all combinations of drug dose and exercise duration with an interaction plot that shows mean glucose levels.


``` r
# Interaction plot
interaction.plot(x.factor = drugExercise$DrugDose,
                 trace.factor = drugExercise$Exercise,
                 response = drugExercise$Glucose,
                 fun = mean,
                 col = hcl.colors(4),
                 xlab = "Drug Dose (mg/kg)",
                 ylab = "Mean Blood Glucose (mg/dL)",
                 trace.label = "Exercise Duration (min)")
```

<img src="fig/complete-random-design-multitreatment-factors-rendered-interaction1-1.png" style="display: block; margin: auto;" />

The interaction plot shows wide variation in mean blood glucose at a drug dose 
of zero. At 20 mg/kg dose, two of the exercise groups have very low blood 
glucose - the zero exercise group and the 15 minute exercise group. For the 60 
minute exercise group, blood glucose increases with drug dose.


``` r
interaction.plot(x.factor = drugExercise$Exercise,
                 trace.factor = drugExercise$DrugDose,
                 response = drugExercise$Glucose,
                 fun = mean,
                 col = hcl.colors(4),
                 xlab = "Exercise (min)",
                 ylab = "Mean Blood Glucose (mg/dL)",
                 trace.label = "DrugDose (mg/kg)")
```

<img src="fig/complete-random-design-multitreatment-factors-rendered-interaction2-1.png" style="display: block; margin: auto;" />

This second interaction plot shows generally declining mean blood glucose with
increased exercise for the 0, 5, and 10 mg/kg drug dosage groups. For the 20 
mg/kg group, mean glucose levels increase dramatically with increased exercise.
If lines were parallel we could assume no interaction between drug and exercise. 
Since they are not  parallel we should assume interaction between exercise and 
drug dose. The F-test from an ANOVA will tell us whether this apparent 
interaction is real or random, specifically whether it is more pronounced than 
would be expected due to random variation.


``` r
# DrugDose*Exercise is the interaction
anova(lm(Glucose ~ DrugDose + Exercise + DrugDose*Exercise, 
         data = drugExercise))
```

``` output
Analysis of Variance Table

Response: Glucose
                  Df Sum Sq Mean Sq  F value    Pr(>F)    
DrugDose           3 1391.6  463.88  71.3651 < 2.2e-16 ***
Exercise           3   85.2   28.39   4.3676  0.007344 ** 
DrugDose:Exercise  9 7826.0  869.56 133.7770 < 2.2e-16 ***
Residuals         64  416.0    6.50                       
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

We can read the ANOVA table from the bottom up, starting with the interaction
(`DrugDose:Exercise`). The `F value` for the interaction is 
133.8
on 
9
and 
64
degrees of freedom for the interaction and error (`Residuals`)
respectively. The p-value (`Pr(>F)`) is near zero and as such the interaction
between exercise and drug dose is significant, backing up what we see in the 
interaction plots. If we move up a row in the table to Exercise, the F test 
compares the exercise means across drug dose groups. The `F value` for exercise
is 
4.4
on 
3
and 
64
degrees of freedom for exercise and residuals respectively. The 
p-value  is low at
0.007
and is significant. Finally, we move up to the row containing `DrugDose` to
find an F value of 
71.4
and a p-value very near zero again. Drug dose averaged over exercise is 
significant.  
The partitioning of treatments sums of squares into main effect (average) and 
interaction sums of squares is a result of the crossed factorial structure of 
the two factors. The development of efficient and informative multifactor 
designs that provide clean partitioning between main effects and interactions
is one of the most important contributions of statistical experimental design.

:::::::::::::::::::::::::::::::::::::::: keypoints

- Completely randomized designs can be structured with two or more factors.
- Random assignment of treatments to experimental units in a single homogeneous group is the same.
- Factorial structure of the experiment requires different analyses, primarily
ANOVA.

::::::::::::::::::::::::::::::::::::::::::::::::::



---
title: Randomized Complete Block Designs
teaching: 0
exercises: 0
source: Rmd
---

::::::::::::::::::::::::::::::::::::::: objectives

- A randomized complete block design randomizes treatments to experimental units within the block.
- Blocking increases the precision of treatment comparisons.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What is randomized complete block design?

::::::::::::::::::::::::::::::::::::::::::::::::::





``` r
g100meansSD <- heart_rate %>%
  group_by(sex, exercise_group) %>%
  summarise(meanChange = round(mean(heart_rate), 3),
            stDev = sd(heart_rate))
```

``` output
`summarise()` has grouped output by 'sex'. You can override using the `.groups`
argument.
```

``` r
g100meansSD
```

``` output
# A tibble: 6 × 4
# Groups:   sex [2]
  sex   exercise_group     meanChange stDev
  <chr> <chr>                   <dbl> <dbl>
1 F     control                  63.0  5.71
2 F     high intensity           63.2  4.95
3 F     moderate intensity       73.8  4.80
4 M     control                  65.8  5.10
5 M     high intensity           60.3  5.05
6 M     moderate intensity       70.3  4.73
```


``` r
ggplot(g100meansSD, aes(x=exercise_group, y=meanChange, group=sex, color=sex)) + 
    geom_line() +
    geom_point() +
    geom_errorbar(aes(ymin=meanChange-stDev, ymax=meanChange+stDev), width=.2,
                  position=position_dodge(0.05), alpha=.5) +
  labs(y = "Heart rate",
       title = "Mean change in heart rate by exercise group and sex") 
```

<img src="fig/complete-random-block-rendered-unnamed-chunk-3-1.png" style="display: block; margin: auto;" />

Blocking of experimental units, as presented in an earlier episode on 
[Experimental Design Principles](https://carpentries-incubator.github.io/statistical-experimental-design/design-principles.html#controlling-natural-variation-with-blocking),
can be critical for successful and valuable experiments. Blocking increases
precision in treatment comparisons relative to an unblocked experiment with the
same experimental units. A randomized block design can be thought of as a set
of separate completely randomized designs for comparing the same treatments. 
Each member of the set is a block, and within this block, each of the treatments
is randomly assigned. We can assess treatment differences within each block
and determine whether treatment differences are consistent from block to block.
In other words, we can determine whether there is an interaction block and
treatment.

## Design issues
The first issue to consider in this case is whether or not to block the
experiment. Blocks serve to control natural variation among experimental units,
and randomization within blocks accounts for "nuisance" variables or traits that 
are likely associated with the response. Shelf height and resulting differences
in illumination is one example of a nuisance variable. Age and sex are 
characteristics of experimental units that can influence the treatment response.
Blocking by age and/or sex is a best practice in experimental design.

<!-- In an earlier episode on  -->
<!-- [Completely Randomized Designs](https://carpentries-incubator.github.io/statistical-experimental-design/complete-random-design.html), -->
<!-- we presented the Generation 100 Study of 3 exercise treatments on men and  -->
<!-- women from 70 to 77 years of age. In the actual study, participants were  -->
<!-- stratified (blocked) by sex and cohabitation status (living with someone vs. -->
<!-- living alone) to form 4 blocks. The three treatment levels (control, moderate- -->
<!-- and high-intensity exercise) were randomly assigned within each block. As such, -->
<!-- we would **analyze** the experiment **as designed** in blocks. -->













<!-- Imagine that you want to evaluate the effect of different doses of a new drug on the proliferation of cancer cell lines in vitro. You use -->
<!-- four different cancer cell lines because you would like the results to -->
<!-- generalize to many types of cell lines. Divide each of the cell lines into four -->
<!-- treatment groups, each with the same number of cells. Each treatment group -->
<!-- receives a different dose of the drug for five consecutive days. -->

<!-- Group 1: Control (no drug)   -->
<!-- Group 2: Low dose (10 μM) -->
<!-- Group 3: Medium dose (50 μM) -->
<!-- Group 4: High dose (100 μM) -->

<!-- ```{r} -->

<!-- # create treatment levels -->
<!-- f <- factor(c("control", "low", "medium", "high")) -->

<!-- # create random orderings of the treatment levels -->
<!-- block1 <- sample(f, 4) -->
<!-- block2 <- sample(f, 4) -->
<!-- block3 <- sample(f, 4) -->
<!-- block4 <- sample(f, 4) -->
<!-- treatment <- c(block1, block2, block3, block4) -->
<!-- block <- factor(rep(c("cellLine1", "cellLine2", "cellLine3", "cellLine4"), each = 4)) -->
<!-- dishnum <- rep(1:4, 4) -->
<!-- plan <- data.frame(cellLine = block, DishNumber = dishnum, treatment = treatment) -->
<!-- plan -->
<!-- ``` -->

When analyzing a random complete block design, the effect of the block is
included in the equation along with the effect of the treatment.

## Randomized block design with a single replication

## Sizing a randomized block experiment

## True replication

## Balanced incomplete block designs



:::::::::::::::::::::::::::::::::::::::: keypoints

- Replication, randomization and blocking determine the validity and usefulness of an experiment.

::::::::::::::::::::::::::::::::::::::::::::::::::



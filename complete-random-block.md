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



## Design issues

Imagine that you want to evaluate the effect of different
doses of a new drug on the proliferation of cancer cell lines in vitro. You use
four different cancer cell lines because you would like the results to
generalize to many types of cell lines. Divide each of the cell lines into four
treatment groups, each with the same number of cells. Each treatment group
receives a different dose of the drug for five consecutive days.

Group 1: Control (no drug)  
Group 2: Low dose (10 μM)
Group 3: Medium dose (50 μM)
Group 4: High dose (100 μM)


``` r
# create treatment levels
f <- factor(c("control", "low", "medium", "high"))

# create random orderings of the treatment levels
block1 <- sample(f, 4)
block2 <- sample(f, 4)
block3 <- sample(f, 4)
block4 <- sample(f, 4)
treatment <- c(block1, block2, block3, block4)
block <- factor(rep(c("cellLine1", "cellLine2", "cellLine3", "cellLine4"), each = 4))
dishnum <- rep(1:4, 4)
plan <- data.frame(cellLine = block, DishNumber = dishnum, treatment = treatment)
plan
```

``` output
    cellLine DishNumber treatment
1  cellLine1          1       low
2  cellLine1          2    medium
3  cellLine1          3      high
4  cellLine1          4   control
5  cellLine2          1       low
6  cellLine2          2   control
7  cellLine2          3    medium
8  cellLine2          4      high
9  cellLine3          1   control
10 cellLine3          2       low
11 cellLine3          3      high
12 cellLine3          4    medium
13 cellLine4          1       low
14 cellLine4          2   control
15 cellLine4          3    medium
16 cellLine4          4      high
```

When analyzing a random complete block design, the effect of the block is
included in the equation along with the effect of the treatment.

## Randomized block design with a single replication

## Sizing a randomized block experiment

## True replication

## Balanced incomplete block designs



:::::::::::::::::::::::::::::::::::::::: keypoints

- Replication, randomization and blocking determine the validity and usefulness of an experiment.

::::::::::::::::::::::::::::::::::::::::::::::::::



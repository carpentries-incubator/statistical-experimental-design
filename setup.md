---
title: Setup
---

---
title: Setup
---

## Software Setup

R is a programming language that is especially powerful for data exploration, 
visualization, and statistical analysis. To interact with R, we use RStudio. 

1. Install the latest version of R from [CRAN](https://cran.r-project.org/).

2. Install the latest version of [RStudio](https://www.rstudio.com/products/rstudio/download/). 
Choose the free RStudio Desktop version for Windows, Mac, or Linux. 

3. Start RStudio. 

4. Install packages by copying and pasting the following code in the R console.

```r
install.packages(c("tidyverse"))
```

Once the installation is complete, load the libraries to make sure that they 
installed correctly. 

```r
library(tidyverse)
```

## Project organization

1. Create a new project in your Desktop called `experimental_design`. 
- Click the `File` menu button, then `New Project`.
- Click `New Directory`. 
- Click `New Project`.
- Type `experimental_design` as the directory name. Browse to your Desktop to create the project there.
- Click the `Create Project` button.

2. Use the `Files` tab to create  a `data` folder to hold the data, a `scripts` folder to 
house your scripts, and a `results` folder to hold results. Alternatively, you can use the 
R console to run the following commands for step 2 only. You still need to create a 
project with step 1.

```r
dir.create("./data")
dir.create("./scripts")
dir.create("./results")
```

## Data Sets

For this course, we will have several data files which you will need to 
download to the `data` directory in the project folder on your Desktop.
Copy, paste, and run the following code in the RStudio console.

Download the files using the code below.

```r
download.file(url      = "https://raw.githubusercontent.com/carpentries-incubator/statistical-experimental-design/refs/heads/main/episodes/data/simulated_heart_rates.csv",
              destfile = "./data/heart_rate.csv",
              mode     = "wb")
download.file(url      = "https://raw.githubusercontent.com/carpentries-incubator/statistical-experimental-design/refs/heads/main/episodes/data/drugExercise.csv",
              destfile = "./data/drugExercise.csv",
              mode     = "wb")
```

Development of this lesson was funded by NIH award GM141520 to Dr. Gary Churchill at The 
Jackson Laboratory.
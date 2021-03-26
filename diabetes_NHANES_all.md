---
title: "NHANES database analysis of glycohemoglobin (A1c) levels"
author: "Ilze"
date: "3/26/2021"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse) 
library(kableExtra)
library(pander)
library(broom)
library(janitor)
```

```{r data wrangling, include=FALSE}
# import dataset:
diabetes_raw <- read.csv("NHANES_diabetes_2009-10.csv", na.strings="")

### tidy data:
# 1- drop unnecessaary columns:
diabetes <- subset(diabetes_raw, select = c(2:10, 14, 17))

# 2- create factor variables:
diabetes <- diabetes %>%
  mutate(
    meds = case_when(
      Meds == 'TRUE' ~ 'yes',
      Meds == 'FALSE' ~ 'no'),
    dm_predm = case_when(
      DM_or_PreDM == 'TRUE' ~  'yes',
      DM_or_PreDM == 'FALSE' ~ 'no'),
    ethnicity = case_when(
      Ethnicity == 'Non-HispanicWhite' ~ 'white',
      Ethnicity == 'Non-HispanicBlack' ~ 'black',
      Ethnicity == 'MexicanAmerican' ~ 'hispanic',
      Ethnicity == 'OtherHispanic' ~ 'hispanic',
      Ethnicity == 'OtherRaceIncludingMulti-Racial' ~ 'other'),
    income_cat = case_when(
      Family_Income == '<20000' | 
        Family_Income == '0 - 5000' |
        Family_Income == '5000 - 10000' |
        Family_Income == '10000 - 15000' |
        Family_Income == '15000 - 20000' |
        Family_Income == '20000 - 25000' ~ 'below_25000',
      Family_Income == '>20000' |
        Family_Income == '25000 - 35000' |
        Family_Income == '35000 - 45000' |
        Family_Income == '45000 - 55000' ~ '25000_55000',
      Family_Income == '55000 - 65000' |
        Family_Income == '65000 - 75000' |
        Family_Income == '75000 - 100000' |
        Family_Income == '>=100000' ~ 'above_55000'),
    a1c_cat = case_when(
      a1c < 5.7 ~ 'normal',
      a1c >= 5.7 & a1c <= 6.5 ~ 'pre_diabetic',
      a1c  > 6.5 ~ 'diabetic'),
    bmi_cat = case_when(
      BMI < 18.5 ~ 'underweight',
      BMI >= 18.5 & BMI < 25 ~ 'normal',
      BMI >= 25 & BMI < 30 ~ 'overweight',
      BMI >= 30 ~ 'obese')
  )
```


```{r  function_colors, include = FALSE}
colorize <- function(x, color) {
  if (knitr::is_latex_output()) {
    sprintf("\\textcolor{%s}{%s}", color, x)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='color: %s;'>%s</span>", color, 
      x)
  } else x
}
```

### 1. Descriptive statistics and visualizations 

#### `r colorize ("**Figure 1. Summary of the study population.**", "#7798A6")`


```{r plot_a1c_bmi_meds_gender, echo = FALSE, message=FALSE}
(a1c_bmi <- ggplot(diabetes, aes(x=a1c, 
                                 y=BMI, 
                                 color = Gender)) +
    geom_point(alpha = 0.5) +
    geom_smooth() +
    facet_wrap(~ meds, nrow = 2) +
    scale_color_manual(values = c("#D9C281", "#7798A6", "#87BAAB", "#cb807d")) +
    labs (title = "Are you on insulin or diabetes meds?",
          subtitle = "A1c (%), BMI and gender distribution",
          y = "BMI",
          x = "A1c (%)") +
    theme(plot.title = element_text(size = rel(2), face = "bold"),
          plot.background = element_rect(fill = "#eaece9"),
          axis.text = element_text(colour = "#565554", face = "bold"),
          axis.title = element_text(colour = "#565554", face = "bold"),
          title = element_text(colour = "#565554"),
          legend.justification = c("right", "top"),
          legend.position = c(1, .30),
          legend.text = element_text(size = 10, colour = "#565554"),
          strip.text.x = element_text(colour = "#565554", face = "bold")))
```


1. individuals on insulin or diabetes medication seem to have A1c levels in the 'normal' range, but those not on medication or insulin appear to have much more dispearsed A1c levels  
2. there don't appear to be visually significant gender differences  
3. BMI appears to be higher for those that report not being on insulin or diabetes medication  
<br><br>

#### `r colorize ("**Table 1. Summary of BMI by gender.**", "#7798A6")`
Mean BMI is significantly higher for women than for men. 

```{r table_bmi_gender, echo = FALSE, message=FALSE, warning = FALSE}
bmi_gender_descr <- group_by(diabetes, Gender) %>% 
  summarise(
    count = n(), 
    mean = mean(BMI, na.rm = TRUE),
    median = median(BMI, na.rm = TRUE),
    min = min(BMI, na.rm=TRUE),
    max = max(BMI, na.rm=TRUE),
    sd = sd(BMI, na.rm = TRUE)) %>% 
  kable(format = "markdown") 

t_bmi_gender <- t.test(diabetes$BMI ~ diabetes$Gender, p.adj = "bonf") 
t_bmi_gender_df <- tidy(t_bmi_gender)
t_bmi_gender_df %>% kable(format = 'markdown', digits = c(5, 32))
```

#### `r colorize ("**Table 2. Summary of BMI by on/off medications.**", "#7798A6")`
Mean BMI is significantly higher for those who are on insulin or diabetes medications. 

```{r table_bmi_meds, echo = FALSE, message=FALSE, warning = FALSE}
bmi_meds_descr <- group_by(diabetes, meds) %>% 
  summarise(
    count = n(), 
    mean = mean(BMI, na.rm = TRUE),
    median = median(BMI, na.rm = TRUE),
    min = min(BMI, na.rm=TRUE),
    max = max(BMI, na.rm=TRUE),
    sd = sd(BMI, na.rm = TRUE)) %>% 
  kable(format = "markdown")

t_bmi_dm <- t.test(diabetes$BMI ~ diabetes$DM_or_PreDM, p.adj = "bonf") 
t_bmi_dm_df <- tidy(t_bmi_dm)
t_bmi_dm_df %>% kable(format = "markdown", digits = c(5, 50))
```

#### `r colorize ("**Table 3. Summary of % glycohemoglobin by gender.**", "#7798A6")`   
Mean A1c levels are significantly higher for males at 95% confidence level. 

```{r table_a1c_gender, echo = FALSE, message=FALSE, warning = FALSE}
a1c_gender_descr <- group_by(diabetes, Gender) %>% 
  summarise(
    count = n(), 
    mean = mean(a1c, na.rm = TRUE),
    median = median(a1c, na.rm = TRUE),
    min = min(a1c, na.rm=TRUE),
    max = max(a1c, na.rm=TRUE),
    sd = sd(a1c, na.rm = TRUE)) %>% 
  kable(format = "markdown")

t_a1c_gender <- t.test(diabetes$a1c ~ diabetes$Gender, p.adj = "bonf") 
t_a1c_gender_df <- tidy(t_a1c_gender)
t_a1c_gender_df %>% kable(format = "markdown", digits = c(5, 32))
```

#### `r colorize ("**Table 4. Summary of % glycohemoglobin by on/off medications.**", "#7798A6")`   
Mean A1c levels are significantly higher for those that are on insulin or diabetes medication as compared to those who are not. 

```{r table_a1c_meds, echo = FALSE, message=FALSE, warning = FALSE}
a1c_meds_descr <- group_by(diabetes, meds) %>% 
  summarise(
    count = n(), 
    mean = mean(a1c, na.rm = TRUE),
    median = median(a1c, na.rm = TRUE),
    min = min(a1c, na.rm=TRUE),
    max = max(a1c, na.rm=TRUE),
    sd = sd(a1c, na.rm = TRUE)) %>% 
  kable(format = "markdown")

t_a1c_meds <- t.test(diabetes$a1c ~ diabetes$meds, p.adj = "bonf") 
t_a1c_meds_df <- tidy(t_a1c_meds)
t_a1c_meds_df %>% kable(format = "markdown", digits = c(5, 50))
```


#### `r colorize ("**Figure 2. Mean BMI by race/ethnicity.**", "#7798A6")`

Individuals that identify as black have the highest mean BMI, followed by hispanic, whie and other. 

```{r plot_bmi_ethnicity, echo = FALSE, message=FALSE}
(bmi_ethn_bar <- ggplot(diabetes, 
                    aes(x = ethnicity,
                        y = BMI, 
                        fill = ethnicity)) +
    geom_boxplot(aes(x=reorder(ethnicity, BMI, FUN=median),
                     y=BMI),
                 outlier.color = "#565554",
                 notch = TRUE,
                 color = "#565554") +
    scale_fill_manual(values = c("#87BAAB", "#D9C281", "#cb807d", "#7798A6")) +
    labs (title = "BMI by ethnicity",
          y = "BMI") +
    theme(plot.title = element_text(size = rel(2), face = "bold"),
          plot.background = element_rect(fill = "#eaece9"),
          axis.text = element_text(colour = "#565554", face = "bold"),
          axis.title = element_text(colour = "#565554", face = "bold"),
          title = element_text(colour = "#565554"), 
          legend.position = "none",
          legend.text = element_text(size = 8, colour = "#565554")))
```
<br><br>

#### `r colorize ("**Table 5. Summary of BMI by ethnicity.**", "#7798A6")`   
There are significant mean BMI differences among the 4 groups with the lowest BMI = 13.18 and the highest BMI = 84.87

```{r table_bmi_ethnicity, echo = FALSE, message=FALSE, warning = FALSE}
bmi_ethnicity_descr <- group_by(diabetes, ethnicity) %>% 
  summarise(
    count = n(), 
    mean = mean(BMI, na.rm = TRUE),
    median = median(BMI, na.rm = TRUE),
    min = min(BMI, na.rm=TRUE),
    max = max(BMI, na.rm=TRUE),
    sd = sd(BMI, na.rm = TRUE)) %>% 
  kable(format = "markdown")
```

#### `r colorize ("**Table 6. Summary of BMI categories by ethnicity.**", "#7798A6")`   
42% of those who identify as black are obese, 36.3% of hispanic individuals are overweight, 45% of 'other' and 33.4% of white individuals have normal BMI. 

```{r table_bmi_ethnicity_percent, echo = FALSE, message=FALSE, warning = FALSE}
bmi_ethn_freq <- diabetes %>% 
  tabyl(ethnicity, bmi_cat) %>% 
  adorn_totals(where = c("row", "col") ) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting() %>%
  adorn_ns( position = "front" ) %>%
  adorn_title("combined") %>% 
  kable(format = "markdown")
```


#### `r colorize ("**Figure 3. Percent glycohemoglobin for those who have vs. have not been diagnosed with diabetes, by gender.**", "#7798A6")`

It appears that individuals who do not have diabetes have A1c levels within the normal range, but those who have diabetes have much larger variation among their A1c levels for both genders. 

```{r plot_a1c_dm, echo = FALSE, message=FALSE}
(a1c_dm_plot <- ggplot(diabetes, 
                    aes(x = a1c, 
                        fill = DM_or_PreDM)) +
    geom_density(alpha=0.9) +
    facet_wrap(~ Gender, nrow = 2) +
    scale_fill_manual(values = c("#D9C281", "#7798A6"),
                      labels = c("No", "Yes")) +
    labs (title = "% A1c and DM diagnosis, by gender",
          y = "Density",
          x = "A1c (%)",
          fill = "DM diagnosis") +
    theme(plot.title = element_text(size = rel(2), face = "bold"),
          plot.background = element_rect(fill = "#eaece9"),
          axis.text = element_text(colour = "#565554", face = "bold"),
          axis.title = element_text(colour = "#565554", face = "bold"),
          title = element_text(colour = "#565554"),
          legend.justification = c("right", "top"),
          legend.position = c(.97, .95),
          legend.text = element_text(size = 10, colour = "#565554"),
          strip.text.x = element_text(colour = "#565554", face = "bold")))
```
<br><br>

#### `r colorize ("**Table 7. Summary of A1c for DM vs. no-DM individuals.**", "#7798A6")`   
There are significant mean A1c level differences between those that have been diagnosed with diabetes as compared to those that have not.

```{r table_a1c_dm_nodm, echo = FALSE, message=FALSE, warning = FALSE}
a1c_dm_descr <- group_by(diabetes, dm_predm) %>% 
    summarise(
      count = n(), 
      mean = mean(a1c, na.rm = TRUE),
      median = median(a1c, na.rm = TRUE),
      min = min(a1c, na.rm=TRUE),
      max = max(a1c, na.rm=TRUE),
      sd = sd(a1c, na.rm = TRUE)) %>% 
  kable(format = "markdown")

t_a1c_dm <- t.test(diabetes$a1c ~ diabetes$dm_predm, p.adj = "bonf") 
t_a1c_dm_df <- tidy(t_a1c_dm)
t_a1c_dm_df %>% kable(format = "markdown")
```

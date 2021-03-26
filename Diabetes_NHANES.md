---
title: "NHANES database analysis of glycohemoglobin (A1c) levels"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse) 
library(kableExtra)
library(pander)
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
a1c_bmi
```


1. individuals on insulin or diabetes medication seem to have A1c levels in the 'normal' range, but those not on medication or insulin appear to have much more dispearsed A1c levels  
2. there don't appear to be visually significant gender differences  
3. BMI appears to be higher for those that report not being on insulin or diabetes medication  
<br><br>

#### `r colorize ("**Table 1. Summary of BMI by gender.**", "#7798A6")`
Mean BMI is significantly higher for women than for men. 

```{r table_bmi_gender, echo = FALSE, message=FALSE, warning = FALSE}
bmi_gender_descr %>% kable(format = "markdown") 
t_bmi_gender_df %>% kable(format = 'markdown', digits = c(5, 32))
```

#### `r colorize ("**Table 2. Summary of BMI by on/off medications.**", "#7798A6")`
Mean BMI is significantly higher for those who are on insulin or diabetes medications. 

```{r table_bmi_meds, echo = FALSE, message=FALSE, warning = FALSE}
bmi_meds_descr %>% kable(format = "markdown")
t_bmi_dm_df %>% kable(format = "markdown", digits = c(5, 50))
```

#### `r colorize ("**Table 3. Summary of % glycohemoglobin by gender.**", "#7798A6")`   
Mean A1c levels are significantly higher for males at 95% confidence level. 

```{r table_a1c_gender, echo = FALSE, message=FALSE, warning = FALSE}
a1c_gender_descr %>% kable(format = "markdown")
t_a1c_gender_df %>% kable(format = "markdown", digits = c(5, 32))
```

#### `r colorize ("**Table 4. Summary of % glycohemoglobin by on/off medications.**", "#7798A6")`   
Mean A1c levels are significantly higher for those that are on insulin or diabetes medication as compared to those who are not. 

```{r table_a1c_meds, echo = FALSE, message=FALSE, warning = FALSE}
a1c_meds_descr %>% kable(format = "markdown")
t_a1c_meds_df %>% kable(format = "markdown", digits = c(5, 50))
```


#### `r colorize ("**Figure 2. Mean BMI by race/ethnicity.**", "#7798A6")`

Individuals that identify as black have the highest mean BMI, followed by hispanic, whie and other. 

```{r plot_bmi_ethnicity, echo = FALSE, message=FALSE}
bmi_ethn_bar
```
<br><br>

#### `r colorize ("**Table 5. Summary of BMI by ethnicity.**", "#7798A6")`   
There are significant mean BMI differences among the 4 groups with the lowest BMI = 13.18 and the highest BMI = 84.87

```{r table_bmi_ethnicity, echo = FALSE, message=FALSE, warning = FALSE}
bmi_ethnicity_descr %>% kable(format = "markdown")
```

#### `r colorize ("**Table 6. Summary of BMI categories by ethnicity.**", "#7798A6")`   
42% of those who identify as black are obese, 36.3% of hispanic individuals are overweight, 45% of 'other' and 33.4% of white individuals have normal BMI. 

```{r table_bmi_ethnicity_percent, echo = FALSE, message=FALSE, warning = FALSE}
bmi_ethn_freq %>% kable(format = "markdown")
```


#### `r colorize ("**Figure 3. Percent glycohemoglobin for those who have vs. have not been diagnosed with diabetes, by gender.**", "#7798A6")`

It appears that individuals who do not have diabetes have A1c levels within the normal range, but those who have diabetes have much larger variation among their A1c levels for both genders. 

```{r plot_a1c_dm, echo = FALSE, message=FALSE}
a1c_dm_plot
```
<br><br>

#### `r colorize ("**Table 7. Summary of A1c for DM vs. no-DM individuals.**", "#7798A6")`   
There are significant mean A1c level differences between those that have been diagnosed with diabetes as compared to those that have not.

```{r table_a1c_dm_nodm, echo = FALSE, message=FALSE, warning = FALSE}
a1c_dm_descr %>% kable(format = "markdown")
t_a1c_dm_df %>% kable(format = "markdown")
```

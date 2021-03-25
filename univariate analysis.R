### univariate analysis / frequency tables

# summary tables for contionus + categorical variables
# BMI as outcome
# 1- bmi by gender
(bmi_gender_descr <- group_by(diabetes, Gender) %>% 
  summarise(
    count = n(), 
    mean = mean(BMI, na.rm = TRUE),
    median = median(BMI, na.rm = TRUE),
    min = min(BMI, na.rm=TRUE),
    max = max(BMI, na.rm=TRUE),
    sd = sd(BMI, na.rm = TRUE)))

# 2- bmi by on/off meds
(bmi_meds_descr <- group_by(diabetes, meds) %>% 
  summarise(
    count = n(), 
    mean = mean(BMI, na.rm = TRUE),
    median = median(BMI, na.rm = TRUE),
    min = min(BMI, na.rm=TRUE),
    max = max(BMI, na.rm=TRUE),
    sd = sd(BMI, na.rm = TRUE)))

# 3- bmi by ethnicity
(bmi_ethnicity_descr <- group_by(diabetes, ethnicity) %>% 
  summarise(
    count = n(), 
    mean = mean(BMI, na.rm = TRUE),
    median = median(BMI, na.rm = TRUE),
    min = min(BMI, na.rm=TRUE),
    max = max(BMI, na.rm=TRUE),
    sd = sd(BMI, na.rm = TRUE)))

# A1C as outcome:
# 1- a1c by gender
(a1c_gender_descr <- group_by(diabetes, Gender) %>% 
  summarise(
    count = n(), 
    mean = mean(a1c, na.rm = TRUE),
    median = median(a1c, na.rm = TRUE),
    min = min(a1c, na.rm=TRUE),
    max = max(a1c, na.rm=TRUE),
    sd = sd(a1c, na.rm = TRUE)))

# 2- a1c by ethnicity
(a1c_ethnicity <- group_by(diabetes, ethnicity) %>% 
  summarise(
    count = n(), 
    mean = mean(a1c, na.rm = TRUE),
    median = median(a1c, na.rm = TRUE),
    min = min(a1c, na.rm=TRUE),
    max = max(a1c, na.rm=TRUE),
    sd = sd(a1c, na.rm = TRUE)))

# 3- a1c by on/off meds
(a1c_meds_descr <- group_by(diabetes, meds) %>% 
  summarise(
    count = n(), 
    mean = mean(a1c, na.rm = TRUE),
    median = median(a1c, na.rm = TRUE),
    min = min(a1c, na.rm=TRUE),
    max = max(a1c, na.rm=TRUE),
    sd = sd(a1c, na.rm = TRUE)))

# 4- a1c by bmi category
(a1c_bmi_descr <- group_by(diabetes, bmi_cat) %>% 
  summarise(
    count = n(), 
    mean = mean(a1c, na.rm = TRUE),
    median = median(a1c, na.rm = TRUE),
    min = min(a1c, na.rm=TRUE),
    max = max(a1c, na.rm=TRUE),
    sd = sd(a1c, na.rm = TRUE)))

# 5- a1c by DM
(a1c_dm_descr <- group_by(diabetes, dm_predm) %>% 
    summarise(
      count = n(), 
      mean = mean(a1c, na.rm = TRUE),
      median = median(a1c, na.rm = TRUE),
      min = min(a1c, na.rm=TRUE),
      max = max(a1c, na.rm=TRUE),
      sd = sd(a1c, na.rm = TRUE)))

# summary tables for categorical + categorical variables
# 1- income by ethnicity 
library(janitor)
(income_ethn_freq <- diabetes %>% 
    filter(!is.na(income_cat)) %>%
    tabyl(ethnicity, income_cat) %>% 
    adorn_totals(where = c("row", "col") ) %>%
    adorn_percentages("row") %>%
    adorn_pct_formatting() %>%
    adorn_ns( position = "front" ) %>%
    adorn_title("combined"))

# 2- income by a1c category 
(income_a1c_freq <- diabetes %>% 
    filter(!is.na(income_cat)) %>%
    tabyl(a1c_cat, income_cat) %>% 
    adorn_totals(where = c("row", "col") ) %>%
    adorn_percentages("row") %>%
    adorn_pct_formatting() %>%
    adorn_ns( position = "front" ) %>%
    adorn_title("combined"))

# 3- ethncity by a1c category
(ethnicity_a1c_freq <- diabetes %>% 
    filter(!is.na(income_cat)) %>%
    tabyl(ethnicity, income_cat) %>% 
    adorn_totals(where = c("row", "col") ) %>%
    adorn_percentages("row") %>%
    adorn_pct_formatting() %>%
    adorn_ns( position = "front" ) %>%
    adorn_title("combined"))

# 4- DM diagnosis by a1c category 
(dm_a1c_freq <- diabetes %>% 
    filter(!is.na(income_cat)) %>%
    tabyl(dm_predm, income_cat) %>% 
    adorn_totals(where = c("row", "col") ) %>%
    adorn_percentages("row") %>%
    adorn_pct_formatting() %>%
    adorn_ns( position = "front" ) %>%
    adorn_title("combined"))

# 5- BMI category by ethncity
(bmi_ethn_freq <- diabetes %>% 
  tabyl(ethnicity, bmi_cat) %>% 
  adorn_totals(where = c("row", "col") ) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting() %>%
  adorn_ns( position = "front" ) %>%
  adorn_title("combined"))




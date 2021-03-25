# load libraries:
library(tidyverse) 
library(rmarkdown)

# import dataset:
diabetes_raw <- read.csv("NHANES_diabetes_2009-10.csv", na.strings="")

# create rmarkdown file: run this when rmarkdown is completed
rmarkdown::render("diabetes_nhanes.Rmd", html_document())

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
        Family_Income == '20000 - 25000' ~ '<25000',
      Family_Income == '>20000' |
        Family_Income == '25000 - 35000' |
        Family_Income == '35000 - 45000' |
        Family_Income == '45000 - 55000' ~ '25000 - 55000',
      Family_Income == '55000 - 65000' |
        Family_Income == '65000 - 75000' |
        Family_Income == '75000 - 100000' |
        Family_Income == '>=100000' ~ '55000+'),
    a1c_cat = case_when(
      a1c < 5.7 ~ 'normal',
      a1c >= 5.7 & a1c <= 6.5 ~ 'pre-diabetic',
      a1c  > 6.5 ~ 'diabetic')
    bmi_cat = case_when(
      BMI < 18.5 ~ 'underweight',
      BMI >= 18.5 & BMI < 25 ~ 'normal',
      BMI >= 25 & BMI < 30 ~ 'overweight',
      BMI >= 30 ~ 'obese')
  )


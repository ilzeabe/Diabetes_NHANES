
|title    | author                     | date         | output        |
|:-------:|:--------------------------:|:------------:|:-------------:|
|README   |https://github.com/ilzeabe  |Mar 16, 2021  | html_document |


#### Purpose
This code explores various associations between glycohemoglobin levels and socioeconomic factors in 2009-2010 National Health And Nutrition Examination Survey (NHANES), given a truncated .csv file containing several demographc and clinical variables.   
  
  
#### Setup

To use this code, use the included `NHANES_diabetes_2009-10.csv` file.

| column name            | description                                       | 
|------------------------|---------------------------------------------------|
| `ID`                     | respondent sequence number                        | 
| `Gender`                 | male/female                                       | 
| `Age`                    | age in years                                      | 
| `Ethnicity`              | race/ethncity                                     |
| `Family_income`          | family income in $US                              |
| `Meds`                   | respondent is on insulin or diabetes meds?        |
| `DM_or_PreDM`            | respondent has DM or PreDM diagnosis?             |
| `Weight`                 | weight in kilograms                               |
| `Height`                 | standing height in centemeters                    |
| `BMI`                    | body mass index                                   |
| `Upper_Leg_Length`       | upper leg length in centemeters                   |
| `Upper_Arm_Length`       | upper arm length in centemeters                   |
| `Arm_Circumference`      | arm circumference in centemeters                  |
| `Waist_Circumference`    | waist circumference in centemeters                |
| `Triceps_Skinfold`       | triceps skinfold in millimeters                   |
| `Subscapular_Skinfold`   | subscapular skinfold in millimeters               |
| `a1c`                    | percent glycohemoglobin                           |
| `Albumin`                | albumin in grams per deciliter                    |
| `Blood_Urea_Nitrogen`    | blood urea nitrogen in milligrams per deciliter   | 
| `Serum_Creatinine`       | serum creatinine in  milligrams per Deciliter     |
  
**The code introduces some modifications:**  

1. `meds` transforms boolean `Meds` to binary yes/no variable  
2. `ethnicity` collapses multiple hispanic values into one  
3. `income_cat` groups `Family_income` into 3 categories  
4. `a1c_cat` groups `a1c` values into 3 categories  

  
#### Running the code:

Packages used:  
`tidyverse` --> use for data wrangling (includes 'ggplot2' used for visualizations)  
`rmarkdown` --> use for creading the .rmd file  
`janitor` --> use for creating the summary tables  
`broom` --> use for creating neat t-test output 
`kableExtra` --> use for table formatting in .Rmd

The code uses a subset of the original dataset to only include variables of interest. 

run `data_prep.r` file before working with other ones

#### Output: 

The code outputs retained columns and new columns to a .csv file. It also outputs visualizations and statistical analysis as an .html file. 

### multivariate analysis

# ---------------------------------------------------------------------
# Chi-square test for bivariate categorical variables
# 1- bmi category and income category
chisq.test(table(diabetes$bmi_cat, diabetes$income_cat)) %>% pander

# 2- % a1c category and income category
chisq.test(table(diabetes$a1c_cat, diabetes$income_cat)) %>% pander

# 3- bmi category and ethnicity
chisq.test(table(diabetes$bmi_cat, diabetes$ethnicity)) %>% pander

# 4- % a1c category and ethnicty
chisq.test(table(diabetes$a1c_cat, diabetes$ethnicity)) %>% pander

# 5- bmi category and gender
chisq.test(table(diabetes$bmi_cat, diabetes$Gender)) %>% pander

# 6- % a1c category and gender 
chisq.test(table(diabetes$a1c_cat, diabetes$Gender)) %>% pander

# 7- bmi category and DM or PreDM diagnosis
chisq.test(table(diabetes$bmi_cat, diabetes$DM_or_PreDM)) %>% pander

# 8- % a1c category and DM or PreDM diagnosis 
chisq.test(table(diabetes$a1c_cat, diabetes$DM_or_PreDM)) %>% pander

# -----------------------------------------------------------------
# ANOVA test for continuous + categorical variables
# 1- BMI and SES
bmi_SES <- aov(BMI ~ income_cat, data=diabetes)
summary(bmi_SES)

# 2- % a1c and SES
a1c_SES <- aov(a1c ~ income_cat, data=diabetes)
summary(a1c_SES)

# 3- BMI and ethnicity
bmi_ethnic <- aov(BMI ~ ethnicity, data=diabetes)
summary(bmi_ethnic)

# 4- % a1c and ethnicity
a1c_ethnic <- aov(a1c ~ ethnicity, data=diabetes)
summary(a1c_ethnic)

# -----------------------------------------------------------------
# t-test for continuous + biniary variables
# 1- BMI and DM dagnosis
library(broom)
t_bmi_dm <- t.test(diabetes$BMI ~ diabetes$DM_or_PreDM, p.adj = "bonf") 
(t_bmi_dm_df <- tidy(t_bmi_dm))

# 2- % a1c and DM dagnosis
t_a1c_dm <- t.test(diabetes$a1c ~ diabetes$dm_predm, p.adj = "bonf") 
(t_a1c_dm_df <- tidy(t_a1c_dm))

# 3- BMI and gender
t_bmi_gender <- t.test(diabetes$BMI ~ diabetes$Gender, p.adj = "bonf") 
(t_bmi_gender_df <- tidy(t_bmi_gender))

# 4- % a1c and gender
t_a1c_gender <- t.test(diabetes$a1c ~ diabetes$Gender, p.adj = "bonf") 
(t_a1c_gender_df <- tidy(t_a1c_gender))

# 5- BMI and on/off medication
t_bmi_meds <- t.test(diabetes$BMI ~ diabetes$meds, p.adj = "bonf") 
(t_bmi_meds_df <- tidy(t_bmi_meds))

# 6- % a1c and on/off medication
t_a1c_meds <- t.test(diabetes$a1c ~ diabetes$meds, p.adj = "bonf") 
(t_a1c_meds_df <- tidy(t_a1c_meds))

# ----------------------------------------------------------------
# linear regression with % a1c as an outcome 
# 1. create dummy variables
library(fastDummies)
diabetes_lm <- dummy_cols(diabetes, select_columns = c('Gender', 
                                                       'ethnicity', 
                                                       'meds', 
                                                       'DM_or_PreDM',
                                                       'income_cat',
                                                       'a1c_cat',
                                                       'bmi_cat'))

# 2. list all varaibles in dummy dataset      
ls(diabetes_lm)

# 3.create a linear model by leavnig out one category from each variable for reference 
lm_a1c <- lm(a1c ~ 
               bmi_cat_normal + bmi_cat_overweight + bmi_cat_obese +  
               DM_or_PreDM_TRUE + 
               ethnicity_black + ethnicity_hispanic + ethnicity_other +  
               Gender_female + 
               income_cat_below_25000 + income_cat_25000_55000 + 
               meds_no + 
               Age,
             data = diabetes_lm)
summary(lm_a1c)

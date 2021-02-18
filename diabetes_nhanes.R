getwd()
setwd("/Users/ilzeabersone/Desktop/Edu/HOPE 2019/Semester 1 - Fall 2019/PHCO_0504_Introduction_to_Biostatistics/Diabetes Data Analysis Project")
getwd()

diabetes <- read.csv("Week_3_NHANES_diabetes.csv")

install.packages("dplyr")
library(dplyr)

summary(diabetes$Gender)
summary(diabetes$Ethnicity)

# Hispanic = 1, Non-HispanicBlack = 2, Non-HispanicWhite=3, OtherRaceIncludingMulti-Racial = 5
# rename MexicanAmerican and OtherHispanic to Hispanic
Race <- factor(c(diabetes$Ethnicity))
levels(Race)[levels(Race) == "4"] <- "1"
Race
Age <- diabetes$Age_in_Years
Waist <- diabetes$Waist_Circumference_in_Centimeters

# combine income into three categories - <25,000, 25,000 - 55,000, 55,000+
diabetes$income_cat <- as.character(diabetes$Family_Income)
typeof(diabetes$income_cat)
diabetes$income_cat [diabetes$Family_Income == "<20000"] <- "<25000"
diabetes$income_cat [diabetes$Family_Income == "0 - 5000"] <- "<25000"
diabetes$income_cat [diabetes$Family_Income == "10000 - 15000"] <- "<25000"
diabetes$income_cat [diabetes$Family_Income == "5000 - 10000"] <- "<25000"
diabetes$income_cat [diabetes$Family_Income == "15000 - 20000"] <- "<25000"
diabetes$income_cat [diabetes$Family_Income == "20000 - 25000"] <- "<25000"
diabetes$income_cat [diabetes$Family_Income == ">20000"] <- "25000 - 55000"
diabetes$income_cat [diabetes$Family_Income == "25000 - 35000"] <- "25000 - 55000"
diabetes$income_cat [diabetes$Family_Income == "35000 - 45000"] <- "25000 - 55000"
diabetes$income_cat [diabetes$Family_Income == "45000 - 55000"] <- "25000 - 55000"
diabetes$income_cat [diabetes$Family_Income == "55000 - 65000"] <- "55000+"
diabetes$income_cat [diabetes$Family_Income == "65000 - 75000"] <- "55000+"
diabetes$income_cat [diabetes$Family_Income == "75000 - 100000"] <- "55000+"
diabetes$income_cat [diabetes$Family_Income == ">=100000"] <- "55000+"

Income <- diabetes$income_cat
Income

# cross tabulate variables
table(Gender, Income)
diabetes %>%
  group_by(diabetes$income_cat, Gender) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n))

table(Race, Income)
diabetes %>%
  group_by(diabetes$income_cat, Ethnicity) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n))

# Waist circumference 
table(Waist, Income)
mean(Waist[Income == "<25000"])
sd(Age[Income == "<25000"])
mean(Age[Income == "25000 - 55000"])
sd(Age[Income == "25000 - 55000"])
mean(Age[Income == "55000+"])
sd(Age[Income == "55000+"])

# anova for age and SES
age_SES <- aov(Age ~ Income, data=diabetes)
summary(age_SES)

# anova for waist and SES
waist_SES <- aov(Waist ~ Income, data=diabetes, na.rm=TRUE)
summary(waist_SES)
summary(Waist)
?aov

waist_Glyco <- aov(Waist ~ Glyco_cat, data=diabetes)
summary(waist_Glyco)

age_Glyco <- aov(Age ~ Glyco_cat, data=diabetes)
summary(age_Glyco)


table(Race, Glyco_cat)
diabetes %>%
  group_by(Glyco_cat, Ethnicity) %>%
  summarise(n = n()) %>%
  mutate(freq = n / sum(n))

# create matrix for chi-square tests
gender_income <- matrix(c(1192, 983, 1086, 1123, 975, 1116), nrow=2)
View(gender_income)
chisq.test(gender_income)

race_income <- matrix(c(915, 437, 700, 123, 878, 426, 776, 129, 1251, 305, 420, 115), nrow=4)
View(race_income)
chisq.test(race_income)


gender_Glyco <- matrix(c(2446, 2388, 709, 670, 268, 314), nrow=2)
View(gender_Glyco)
chisq.test(gender_Glyco)

race_Glyco <- matrix(c(2345, 755, 1456, 278, 567, 338, 406, 68, 205, 124, 210, 43), nrow=4)
View(race_Glyco)
chisq.test(race_Glyco)

income_Glyco <- matrix(c(1500, 1520, 1601, 477, 467, 356, 198, 222, 134), nrow=3)
View(income_Glyco)
chisq.test(income_Glyco)


# reshape data for ANOVA
cbind(Waist)
cbind(Income)
df_waist_income <- data.frame(Waist, Income)
df_waist_income[order(Income),]
df_waist_income
boxplot(Waist ~ Income)
wais_income_aov <- aov(Waist ~ Income, data=diabetes)
summary(wais_income_aov) 

cbind(Glyco_cat)
df_waist_income <- data.frame(Waist, Glyco_cat)
df_waist_income
boxplot(Waist ~ Glyco_cat)
wais_Glyco_aov <- aov(Waist ~ Glyco_cat, data=diabetes)
summary(wais_Glyco_aov) 

cbind(Age)
df_age_income <- data.frame(Age, Income)
df_age_income
boxplot(Age ~ Income)
age_income_aov <- aov(Age ~ Income, data=diabetes)
summary(age_income_aov) 


df_age_glyco <- data.frame(Age, Glyco_cat)
df_age_glyco
boxplot(Age ~ Glyco_cat)
age_glyco_aov <- aov(Age ~ Glyco_cat, data=diabetes)
summary(age_glyco_aov) 







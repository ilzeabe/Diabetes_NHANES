# 1- scatter plot: weight vs. bmi by gender and diabetes medication status
(weight_bmi <- ggplot(data=diabetes) +
  geom_point(mapping = aes(x=Weight, y=BMI, color = Gender), alpha = 0.5) +
  facet_wrap(~ meds, nrow = 2) +
  scale_color_manual(values = c("#D9C281", "#7798A6", "#87BAAB", "#cb807d")) +
  labs (title = "Are you on insulin or diabetes meds?",
        subtitle = "Weight (kg), BMI and gender distribution",
        y = "BMI",
        x = "Weight (kg)") +
  theme(plot.title = element_text(size = rel(2), face = "bold"),
        plot.background = element_rect(fill = "#eaece9"),
        axis.text = element_text(colour = "#565554", face = "bold"),
        axis.title = element_text(colour = "#565554", face = "bold"),
        title = element_text(colour = "#565554"),
        legend.justification = c("right", "top"),
        legend.position = c(.97, .22),
        legend.text = element_text(size = 10, colour = "#565554"),
        strip.text.x = element_text(colour = "#565554", face = "bold")))

# 2- scatter plot: % A1c vs. bmi by gender and diabetes medication status
(a1c_bmi <- ggplot(diabetes, aes(x=a1c, y=BMI, color = Gender)) +
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

# 3- scatter plot: age vs. a1c level
(age_a1c <- ggplot(diabetes, aes(x=Age, y = a1c)) +
    geom_point(aes(color = Gender),
               alpha = 0.5) +
    geom_smooth(method = "lm", color = '#565554') +
    scale_color_manual(values = c("#D9C281", "#7798A6", "#87BAAB", "#cb807d")) +
    labs (title = "A1c level by age",
          subtitle = "Includes gender differences",
          y = "% A1c",
          x = "Age") +
    theme(plot.title = element_text(size = rel(2), face = "bold"),
          plot.background = element_rect(fill = "#eaece9"),
          axis.text = element_text(colour = "#565554", face = "bold"),
          axis.title = element_text(colour = "#565554", face = "bold"),
          title = element_text(colour = "#565554"),
          legend.justification = c("right", "top"),
          legend.position = c(.23, .99),
          legend.text = element_text(size = 10, colour = "#565554"),
          strip.text.x = element_text(colour = "#565554", face = "bold")))

# 4- boxplot: bmi by ethnicity
(bmi_ethn <- ggplot(diabetes, aes(x = ethnicity,y = BMI, fill = ethnicity)) +
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

# 5- barplot: income category by ethnicity 
(income_ethnic <- diabetes %>%
    filter(!is.na(income_cat)) %>%
    ggplot() +
    geom_bar(aes(x=income_cat, 
                 fill = ethnicity),
             position = "dodge",
             width = 0.5)+
    scale_fill_manual(values = c("#87BAAB", "#D9C281", "#cb807d", "#7798A6")) +
    labs (title = "Income category by ethnicity",
          y = "Count",
          x = "Income category") +
    theme(plot.title = element_text(size = rel(2), face = "bold"),
          plot.background = element_rect(fill = "#eaece9"),
          axis.text = element_text(colour = "#565554", face = "bold"),
          axis.title = element_text(colour = "#565554", face = "bold"),
          title = element_text(colour = "#565554"),
          legend.position = "right",
          legend.title = element_text(size = 8, colour = "#565554"),
          legend.text = element_text(size = 8, colour = "#565554")))

# 6- density plot: waist circumference for those that have and don't have DM diagnosis 
(waist_dm <- ggplot(diabetes, 
                    aes(x = Waist_Circumference, 
                        fill = DM_or_PreDM)) +
    geom_density(alpha=0.9) +
    facet_wrap(~ Gender, nrow = 2) +
    scale_fill_manual(values = c("#D9C281", "#7798A6"),
                      labels = c("No", "Yes")) +
    labs (title = "Waist circumference and DM diagnosis",
          y = "Density",
          x = "Waist circumference (cm)",
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

# 7- density plot: % a1c for those that have and don't have DM diagnosis 
(a1c_dm_plot <- ggplot(diabetes, aes(x = a1c, fill = DM_or_PreDM)) +
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

# 8- stacked bar plot: income category vs. a1c category 
income_a1c_bar <- diabetes %>%
  group_by(a1c_cat) %>%
  filter(income_cat != 'NA')      #  first remove NA from income_cat

(income_a1c <- ggplot(income_a1c_bar,
                      aes(x = a1c_cat, fill = income_cat)) +
    geom_bar(aes(x=reorder(a1c_cat, income_cat)),
             position = 'fill', width = 0.8, na.rm=TRUE) +
    scale_fill_manual(values = c("#87BAAB", "#D9C281", "#cb807d", "#7798A6")) +
    labs(title = 'Income category vs. A1c category',
         y = 'proportion',
         x = 'A1c category',
         fill = "Income ($)")) +
  theme(plot.title = element_text(size = rel(2), face = "bold"),
        plot.background = element_rect(fill = "#eaece9"),
        axis.text = element_text(colour = "#565554", face = "bold"),
        axis.title = element_text(colour = "#565554", face = "bold"),
        title = element_text(colour = "#565554"),
        legend.justification = c("right", "center"),
        legend.text = element_text(size = 10, colour = "#565554"),
        strip.text.x = element_text(colour = "#565554", face = "bold"))

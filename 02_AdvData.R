# === === === === === === === === === === === === === === === === === === 
# Created by Gabe Veltri on 11/18/2024
# Project: Help
# Goal: More advanced data work
# === === === === === === === === === === === === === === === === === ===

### LOG TRANSFORMS ###
# Load Libraries
library(openintro)
library(dplyr)
library(ggplot2)
library(e1071)

# Visualise Data
data("mammals")
ggplot(data = mammals, aes(body_wt)) + geom_histogram()
ggplot(data = mammals, aes(brain_wt)) + geom_histogram()

# Assessing skew
skewness(mammals$body_wt)
skewness(mammals$brain_wt)

# Skew Table
#   0 = symmetrical
#   >+1 or <-1 = highly skewed
#   between-1 and -0.5 or between +1 and +0.5 = moderately skewed
#   between -0.5 and +0.5 = approximately symmetric

# Because the data is skewed it is hard to see any relationship
ggplot(mammals, aes(body_wt, brain_wt)) + geom_point()

# HOWEVER a log transformation changes that
ggplot(data = mammals, aes(x = body_wt, y = brain_wt)) +
  geom_point() +
  scale_x_log10() + scale_y_log10()

# Creating a Linear Regression Model to Predict BrainWt based on the BodyWt using the raw values from the dataset
lm.model = lm(brain_wt ~ body_wt, data = mammals)
summary(lm.model)                                   #shows us the residual is too high

# Log transformed Model
lm_log.model = lm(log1p(brain_wt) ~ log1p(body_wt), data = mammals)
summary(lm_log.model)                               #residual decreased A LOT

# === === === === === === === === === === === === === === === === === ===

### ANOVA ###

#Package Loading
library(tidyverse)
library(ggpubr)
library(rstatix)

#Data Prep
data("PlantGrowth") 
set.seed(1234)
PlantGrowth %>% sample_n_by(group, size = 1)    #inspect the data

levels(PlantGrowth$group) #shows levels of grouping variable

PlantGrowth <- PlantGrowth %>%
  reorder_levels(group, order = c("ctrl", "trt1", "trt2"))  #Reorder variables

#Summary Stats
PlantGrowth %>%
  group_by(group) %>%
  get_summary_stats(weight, type = "mean_sd")   #count, mean and sd

#Visualization
ggboxplot(PlantGrowth, x = "group", y = "weight") #boxplot of weight by group

# CHECK ASSUMPTIONS

# Identify Outliers
PlantGrowth %>% 
  group_by(group) %>%
  identify_outliers(weight)

# Normality
#Build the linear model
model  <- lm(weight ~ group, data = PlantGrowth)
#Create a QQ plot of residuals
ggqqplot(residuals(model))

#Shapiro-Wilk Test
PlantGrowth %>%
  group_by(group) %>%
  shapiro_test(weight)

#QQplot for each group
ggqqplot(PlantGrowth, "weight", facet.by = "group")

# Homogenetity of Variance
#Graphing
plot(model, 1)

#Levene's Test
PlantGrowth %>% levene_test(weight ~ group) #ideally we want a non-significant P-value

# COMPUTATION
res.aov <- PlantGrowth %>% anova_test(weight ~ group)
res.aov

# POST-HOC TESTS
# Pairwise comparisons
pwc <- PlantGrowth %>% tukey_hsd(weight ~ group)
pwc

# REPORT
# Visualization: box plots with p-values
pwc <- pwc %>% add_xy_position(x = "group")
ggboxplot(PlantGrowth, x = "group", y = "weight") +
  stat_pvalue_manual(pwc, hide.ns = TRUE) +
  labs(
    subtitle = get_test_label(res.aov, detailed = TRUE),
    caption = get_pwc_label(pwc)
  )

# RELAXING HOMOGENEITY OF VARIANCE ASSUMPTION
# Welch One way ANOVA test
res.aov2 <- PlantGrowth %>% welch_anova_test(weight ~ group)
# Pairwise comparisons (Games-Howell)
pwc2 <- PlantGrowth %>% games_howell_test(weight ~ group)
# Visualization: box plots with p-values
pwc2 <- pwc2 %>% add_xy_position(x = "group", step.increase = 1)
ggboxplot(PlantGrowth, x = "group", y = "weight") +
  stat_pvalue_manual(pwc2, hide.ns = TRUE) +
  labs(
    subtitle = get_test_label(res.aov2, detailed = TRUE),
    caption = get_pwc_label(pwc2)
  )

# === === === === === === === === === === === === === === === === === ===

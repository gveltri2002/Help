# === === === === === === === === === === === === === === === === === === 
# Created by Gabe Veltri on 2/4/2025
# Project: Help
# Goal: Work though R For Data Science Book
# === === === === === === === === === === === === === === === === === ===

### INTRO ###

# Important Packages
install.packages(
  c("arrow", "babynames", "curl", "duckdb", "gapminder", 
    "ggrepel", "ggridges", "ggthemes", "hexbin", "janitor", "Lahman", 
    "leaflet", "maps", "nycflights13", "openxlsx", "palmerpenguins", 
    "repurrrsive", "tidymodels", "writexl")
)

# === === === === === === === === === === === === === === === === === ===

### WHOLE GAME ###

#### Data Visualization ####
library(tidyverse)
library(palmerpenguins)  #contains a dataset
library(ggthemes)  #colorblind friendly palette

# === === === === === ===
## First Steps ##
# Do penguins with longer flippers weigh more or less than penguins with shorter flippers? What does the relationship between flipper length and body mass look like? Is it positive? Negative? Linear? Nonlinear? Does the relationship vary by the species of the penguin? How about by the island where the penguin lives? 

# Let’s create visualizations that we can use to answer these questions.

glimpse(penguins)
view(penguins)

ggplot(
  data = penguins, 
  mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm") + # line of best fit based on "linear model"
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions fo Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    color = "Species", shape = "Species" # changes legend display
  ) +
  scale_color_colorblind() #chooses a colorblind friendly palatte

# Exercises
length(penguins) # 8 columns
length(penguins$species) # 344 rows

?penguins
?labs

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(na.rm = TRUE) +
  labs(
    caption = "Data come from the palmerpenguins package."
  )

ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)) +
  geom_boxplot()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(color = bill_depth_mm)) +
  geom_smooth()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# === === === === === ===

## ggplot2 Calls ##

# This is very explicit:
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()

# but can be condensed to
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

# === === === === === ===

## Visualizing Distributions ##

# Categorical Variables
ggplot(penguins, aes(x = species)) +
  geom_bar()

ggplot(penguins, aes(x = fct_infreq(species))) +  # reorders the bars!
  geom_bar()



# Numerical Variables
ggplot(penguins, aes(x = body_mass_g)) + # histograms
  geom_histogram(binwidth = 200)

ggplot(penguins, aes(x = body_mass_g)) + # density plots => smoothed histograms
  geom_density()



# Exercises
ggplot(penguins, aes(y = species)) +
  geom_bar()

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

ggplot(penguins, aes(x = body_mass_g)) + # histograms
  geom_histogram(bins = 5)

glimpse(diamonds)

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.5)

# === === === === === ===

## Visualizing Relationships => mapping 2 variables

# Numerical + Categorical => boxplots and density plots
ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)



# Two Categorical => stacked bar chart and relative frequency plots
ggplot(penguins, aes(x = island, fill = species)) + # stacked bat chart
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) + # relative frq plot
  geom_bar(position = "fill") # NOTE THE CHANGE



# Two Numerical => scatter plots/smooth curves
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()



# 3 or More => mapping additional aesthetics/facets
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species)) +
  facet_wrap(~island)



# Exercises
glimpse(mpg)
?mpg

ggplot(mpg, aes(x = hwy, y = displ))+
  geom_point(aes(size = drv))

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm, color = species))+
  geom_point() +
  scale_color_colorblind() 

ggplot(penguins, aes(x = bill_length_mm, y = bill_depth_mm))+
  geom_point() +
  facet_wrap(~species) + 
  scale_color_colorblind() 

ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, 
    y = bill_depth_mm, 
    color = species, 
    shape = species
  )
) +
  geom_point() +
  labs(color = "Species", shape = "Species")


ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")


ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")
# === === === === === ===

## Saving Your Plots ##

# Use ggsave() to save plots
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
ggsave(filename = "penguin-plot.png")



# Exercises
ggplot(mpg, aes(x = class)) +
  geom_bar()

ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg-plot.png")

?ggsave
ggsave("mpg-plot.pdf")

# === === === === === ===

## Common Problems ##

# - Check syntax: match parenthesis and ", 
# - Make sure + is at the end of the line for ggplot
# - use ? if you get stuck

# === === === === === ===

#### end ####

#### Workflow: Basics ####

# === === === === === ===

## Coding Basics ##
# You can combine multiple elements into a vector with c():
primes <- c(2, 3, 5, 7, 11, 13)

# === === === === === ===

## Comments ##
# Use comments to explain the WHY of your code, not the HOW or the WHAT => why is usually impossible to figure out

# === === === === === ===

## What's in a Name ##
# Recommend using snake_case => lowercase words separated by _
this_is_a_really_long_name <- 3.5

# === === === === === ===

## Calling Functions ##

seq(1, 10)
#> [1]  1  2  3  4  5  6  7  8  9 10

# === === === === === ===

## Exercises ##
library(tidyverse)

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(method = "lm")

# === === === === === ===

#### end ####

#### Data Transformation ####

# === === === === === ===

## Introduction ##

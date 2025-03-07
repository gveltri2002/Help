# === === === === === === === === === === === === === === === === === === 
# Created by Gabe Veltri on 2/4/2025
# Project: Help
# Goal: Work though R For Data Science Book: Whole Game Section
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
library(nycflights13)
library(tidyverse)

View(flights)
glimpse(flights)

## Dplyr Basics ##
# 1. The first argument is always a data frame.
# 2. The subsequent arguments typically describe which columns to operate on using the variable names (without quotes).
# 3. The output is always a new data frame.

flights %>% 
  filter(dest == "IAH") %>%  
  group_by(year, month, day) %>% 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# === === === === === ===

## Rows ##

# filter() = changes which ROWS are present without changing the order
flights %>% 
  filter(dep_delay > 120)

#Flights that departed on January 1
flights %>% 
  filter(month == 1 & day == 1)

#Flights that departed in January OR February
flights %>% 
  filter(month == 1 | month == 2)

flights %>% 
  filter(month %in% c(1, 2))



# arrange() = changes the order of ROWS based on which columns are present, doesn't filter data
flights %>% 
  arrange(year, month, day, dep_time) #filters by earliest year, then month, then dep_time

flights %>% 
  arrange(desc(dep_delay)) #desc() = orders big to small (descending)



# distinct() = finds unique rows in a dataset
# Remove duplicate rows, if any
flights %>% 
  distinct()

# Find all unique origin and destination pairs
flights %>% 
  distinct(origin, dest)

flights %>% 
  distinct(origin, dest, .keep_all = TRUE) # .keep_all = keeps all other columns



# count() = counts the number of rows that meet unique criteria
flights %>% 
  count(origin, dest, sort = TRUE)



# Exercises
names(flights)
flights %>% 
  filter(arr_delay >= 120)

flights %>%
  filter(dest == "IAH" | dest == "HOU")

flights %>%
  filter(month %in% c(7, 8, 9))

flights %>%
  filter(arr_delay > 120 & dep_delay <= 0)

flights %>%
  filter(dep_delay >= 60 & arr_delay < 30)


flights %>% 
  arrange(desc(dep_delay))

flights %>% 
  arrange(sched_dep_time)

flights %>%
  arrange(air_time) %>% 
  select(air_time)

flights %>% 
  distinct(year, month, day)

flights %>%
  distinct(flight, distance) %>% 
  arrange(desc(distance))
  
flights %>%
  distinct(flight, distance) %>% 
  arrange(distance)

# === === === === === ===

## Columns ##

# mutate() = make news columns from old
flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day # adds new columns after day instead of left side
  )

flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

# select() = choses which columns to display
#Select columns by name:
flights %>% 
  select(year, month, day)

#Select all columns between year and day (inclusive):
flights %>% 
  select(year:day)

#Select all columns except those from year to day (inclusive):
flights %>% 
  select(!year:day)



# Exercises
flights %>% 
  select(dep_time, sched_dep_time, dep_delay)

flights %>% 
  select(day, year, day, day)

variables <- c("year", "month", "day", "dep_delay", "arr_delay")

flights %>% 
  select(any_of(variables))

flights %>% 
  select(contains("time", ignore.case = FALSE))
?contains

# === === === === === ===

## The Pipe ##
# Allows you to combine multiple commands together => ex find the fastest flights to IAH
flights %>% 
  filter(dest == "IAH") %>% 
  mutate(speed = distance / air_time * 60) %>% 
  select(year:day, dep_time, carrier, flight, speed) %>% 
  arrange(desc(speed))

# === === === === === ===

## Groups

# group_by() = divide data set into groups meaningful for analysis, subsequent outputs work in the group
flights %>%
  group_by(month)



# summarize() = presents summary stats, if used with group does one per group
flights %>% 
  group_by(month) %>% 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    n = n()
  )



# slice_ = allows you to extract specific rows from groups
flights %>% 
  group_by(dest) %>% 
  slice_max(arr_delay, n = 1) %>% # n = # can be replaced with p = # to give a proportion of the data set
  relocate(dest)



# You can group my multiple variables
daily <- flights %>%  
  group_by(year, month, day)



# ungroup() = ungroups the data
daily %>% 
  ungroup()

# .by = can be used to group within a single operation
flights %>% 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = month
  )

flights %>% 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = c(origin, dest)
  )



# Exercises
flights %>% 
  group_by(carrier) %>% 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE)) %>% 
  arrange(desc(delay))

car_dest <- flights %>% 
  group_by(carrier, dest) %>% 
  summarize(n())
view(car_dest)


flights %>% 
  select(month, day, flight, dest, dep_delay) %>% 
  group_by(dest) %>% 
  slice_max(dep_delay, n = 1) %>% 
  arrange(dest)


flights %>% 
  select(year, month, day, dep_time, dep_delay) %>%
  ggplot(., aes(dep_time, dep_delay)) +
    geom_smooth()


flights %>% 
  select(month, day, flight, dest, dep_delay) %>% 
  group_by(dest) %>% 
  slice_min(dep_delay, n = -1) %>% 
  arrange(dest)

flights %>% 
  count(dest, sort = TRUE)

df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

df %>%
  group_by(y)

df %>%
  arrange(y)

df %>%
  group_by(y) %>%
  summarize(mean_x = mean(x))

df %>%
  group_by(y, z) %>%
  summarize(mean_x = mean(x))

df %>%
  group_by(y, z) %>%
  summarize(mean_x = mean(x), .groups = "drop")

df %>%
  group_by(y, z) %>%
  mutate(mean_x = mean(x))

# === === === === === ===

## Case Study: aggregates and sample size
install.packages("Lahman")
library(Lahman)

batters <- Lahman::Batting %>% 
  group_by(playerID) %>% 
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )
view(batters)

batters %>% 
  filter(n > 100) %>% 
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) + 
  geom_smooth(se = FALSE)



#### end ####

#### Workflow: Code Style ####

## Intro
library(styler)
library(tidyverse)
library(nycflights13)
# sytler can be used to change the style of your code quickly and easily



## Names
# Strive for:
short_flights <- flights |> filter(air_time < 60)

## Spaces
# Strive for = spaces after operators, commas, but not in/outside parenthesis
z <- (a + b)^2 / d
mean(x, na.rm = TRUE)

# Its okay to add extra spaces for alignment
flights |> 
  mutate(
    speed      = distance / air_time,
    dep_hour   = dep_time %/% 100,
    dep_minute = dep_time %%  100
  )



## Pipes
# Should always be the last thing on the line, when piping into arugments (ie. mutate) put each argument on a new line
flights |>  
  group_by(tailnum) |> 
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )



## Exercises
flights |> 
  filter(dest == "IAH") |>
  group_by(year, month, day) |> 
  summarize(
    n = n(),
    delay = mean(arr_delay, na.rm = TRUE)) |> 
  filter(n>10)

flights |> 
  filter(
    carrier == "UA", 
    dest %in% c("IAH", "HOU"),
    sched_dep_time > 0900,
    sched_arr_time < 2000) |>
  group_by(flight) |>
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    cancelled = sum(is.na(arr_delay)), n = n()) |>
  filter(n > 10)

#### end ####

#### Data Tidying ####
library(tidyverse)

## Lengthening Data
View(billboard)

billboard_longer <- billboard %>%  
  pivot_longer(
    cols = starts_with("wk"), #select the variables that need to be pivoted
    names_to = "week", #names the variable stored in the column name
    values_to = "rank", #names the variable sored in the cell value
    values_drop_na = TRUE #get rid of NA
  ) %>%
  mutate(
    week = parse_number(week) # parse_number extracts the first number from a string
  )

billboard_longer %>% 
  ggplot(aes(x = week, y = rank, group = track)) + 
  geom_line(alpha = 0.25) + 
  scale_y_reverse()



# Many Variables in column names
View(who2)

who2 %>% 
  pivot_longer(
    cols = !(country:year), #selects all columns excluding country + year
    names_to = c("diagnosis", "gender", "age"), 
    names_sep = "_", 
    values_to = "count"
  )



# Data and variable namesin column headings
household

household |> 
  pivot_longer(
    cols = !family, 
    names_to = c(".value", "child"), #This overrides the usual values_to argument to use the first component of the pivoted column name as a variable name in the output.
    names_sep = "_", 
    values_drop_na = TRUE
  )



## Widening data
cms_patient_experience

cms_patient_experience |> 
  pivot_wider(
    id_cols = starts_with("org"), # unique ID for each row
    names_from = measure_cd,
    values_from = prf_rate
  )

#### end ####

#### Data Import ####
library(tidyverse)
library(readr)
library(janitor)

## Reading data from a file
# CSV
students <- read.csv("https://pos.it/r4ds-students-csv", na = c("N/A", "")) #changes blanks and N/A to recognize as NA

students %>% 
  janitor::clean_names() %>% # will clean names easily
  mutate(
    meal_plan = factor(meal_plan),
    age = parse_number(if_else(age == "five", "5", age)))



# Exercises
read_csv("x,y\n1,'a,b'", quote ="'")

read_csv("a,b,c\n1,2,3\n4,5,6")
read_csv("a,b,c,d\n1,2\n1,2,3,4")
read_csv("a,b\n1,2\na,b")
read_csv2("a;b\n1;3")

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

annoying %>% 
  select(`1`)

annoying %>% 
  ggplot(aes(x = `1`, y = `2`))+
  geom_point()

annoying <- annoying %>% 
  mutate(`3` = `2`/`1`)

annoying <- annoying %>%
  rename(
    Three = `3`,
    Two = `2`,
    One = `1`)




## Controlling column types
simple_csv <- "
  x
  10
  .
  20
  30"

df <- read_csv(
  simple_csv, 
  col_types = list(x = col_double())
)

problems(df)

read_csv(simple_csv, na = ".")


# Combining data from multiple tables
sales_files <- c(
  "https://pos.it/r4ds-01-sales",
  "https://pos.it/r4ds-02-sales",
  "https://pos.it/r4ds-03-sales"
)

read_csv(sales_files, id = "file")

#### end ####

# === === === === === === === === === === === === === === === === === ===

### VISUALIZE ###

#### Layers ####
library(tidyverse)

## Aesthetics Mapping
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, shape = class)) + # shape can only handle 6 varaibles
  geom_point()

# Exercises
ggplot(mpg, aes(displ, hwy)) +
  geom_point(shape = 24, fill = "pink", stroke = 0.7)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy), color = "blue")

?geom_point

ggplot(mpg, aes(displ, hwy, color = displ < 5)) +
  geom_point()



## Geometric Objects
# Exercises
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(se = F) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(group = drv), se = F) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(se = F) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(se = F) +
  geom_point(aes(color = drv))

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth(aes(linetype = drv), se = F) +
  geom_point(aes(color = drv))

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "white",size = 4) +
  geom_point(aes(color = drv))




## Facets
# used to subset data based on categorical variables
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~cyl)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ cyl)

# Exercises
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_wrap(~displ)

ggplot(mpg) + 
  geom_point(aes(x = drv, y = cyl))

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) + 
  facet_wrap(~ cyl, nrow = 2)

?facet_wrap

ggplot(mpg, aes(x = displ)) + 
  geom_histogram() + 
  facet_grid(drv ~ .)

ggplot(mpg, aes(x = displ)) + 
  geom_histogram() +
  facet_grid(. ~ drv)

ggplot(mpg) + 
  geom_point(aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)



## Statistical Transformations
ggplot(diamonds, aes(x = cut)) + 
  geom_bar()

ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) + 
  geom_bar()

ggplot(diamonds) + 
  stat_summary(
    aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

# Exercises
?stat_summary

diamonds |>
  group_by(cut) |>
  summarize(
    lower = min(depth),
    upper = max(depth),
    midpoint = median(depth)
  ) |>
  ggplot(aes(x = cut, y = midpoint)) +
  geom_pointrange(aes(ymin = lower, ymax = upper))

?geom_col
?stat_smooth

ggplot(diamonds, aes(x = cut, y = after_stat(prop))) + 
  geom_bar()
ggplot(diamonds, aes(x = cut, fill = color, y = after_stat(prop))) + 
  geom_bar()



## Position Adjustments
# Stacked Bar Charts
ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar(position = "fill") # good for comparing proportions

ggplot(mpg, aes(x = drv, fill = class)) + 
  geom_bar(position = "dodge") # puts everything next to each other

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(position = "jitter") # allows plotting high density data with overlap

# Exercises
ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_jitter()
ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_count()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(position = "identity")

?geom_jitter
?geom_count
?geom_boxplot

ggplot(mpg, aes(x = displ, y = cty)) +
  geom_boxplot()



## Coordinate Systems
nz <- map_data("nz")

ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap() #sets the aspect ratio correctly for geographic maps

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = clarity, fill = clarity), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1)

bar + coord_flip()
bar + coord_polar() # polar coordinates

# Exercises
ggplot(mpg, aes(x = "", fill = class)) +
  geom_bar(position = "fill") +
  coord_polar(theta = "y")

?coord_map()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()

?geom_abline
?coord_fixed

#### end ####

#### Exploratory Data Analysis ####
library(tidyverse)

## Variation
# Exercises
ggplot(diamonds, aes(x = x)) + 
  geom_histogram()

ggplot(diamonds, aes(x = y)) + 
  geom_histogram(binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

ggplot(diamonds, aes(x = z)) + 
  geom_histogram(binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))



## Unusual Values
# Exercises
library("nycflights13")
View(flights)

nycflights13::flights |> 
  ggplot(aes(x = dep_time)) +
  geom_histogram()



## Covariation
# Exercises
nycflights13::flights |> 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + (sched_min / 60)
  ) |> 
  ggplot(aes(x = sched_dep_time, y = after_stat(density))) + 
  geom_freqpoly(aes(color = cancelled), binwidth = 1/4)

view(diamonds)
tibble(diamonds)

diamonds %>% 
  ggplot(aes(x = clarity, y = price)) +
  geom_boxplot()

diamonds %>% 
  ggplot(aes(x = carat, y = price)) +
  geom_smooth()

diamonds %>% 
  ggplot(aes(x = carat, y = price, color = cut)) +
  geom_smooth()

install.packages("lvplot")
library(lvplot)

diamonds %>% 
  ggplot(aes(x = cut, y = price)) +
  geom_lv()

diamonds %>% 
  ggplot(aes(x = cut, y = price)) +
  geom_violin()

diamonds %>% 
  ggplot(aes(x = price)) +
  geom_histogram() +
  facet_grid(cut ~ .)

diamonds %>% 
  ggplot(aes(x = price)) +
  geom_freqpoly(aes(color = cut))

diamonds %>% 
  ggplot(aes(x = price)) +
  geom_density(aes(color = cut))

?cut_number
smaller <- diamonds %>% 
  filter(carat < 3)

ggplot(smaller, aes(x = carat, y = price)) +
  geom_point()
  
ggplot(smaller, aes(x = price, y = carat)) + 
  geom_boxplot(aes(group = cut_width(price, 500)))

ggplot(smaller, aes(x = carat, y = price)) +
  geom_point() +
  facet_grid(cut ~ .)

diamonds |> 
  filter(x >= 4) |> 
  ggplot(aes(x = x, y = y)) +
  geom_point() +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))

ggplot(smaller, aes(x = carat, y = price)) + 
  geom_boxplot(aes(group = cut_number(carat, 20)))

#### end ####

#### Communication ####
library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

## Labels
# Exercises
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, shape = "Highway"), color = "black") +
  geom_point(aes(x = displ, y = cty, shape = "City"), color = "blue") +
  labs(
    x = "Engine displacement (L)",
    y = "Fuel economy (mpg)",
    shape = "Road Type",
    title = "Fuel efficiency generally decreases with engine size",
    caption = "Data from fueleconomy.gov")

ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point(aes(color = drv, shape = drv)) +
  labs(
    x = "City (mpg)",
    y = "Highway (mpg)",
    shape = "Type of Drive Train",
    color = "Type of Drive Train"
  )

#### end ####






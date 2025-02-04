# === === === === === === === === === === === === === === === === === === 
# Created by Gabe Veltri on 1/16/2025
# Project: Help
# Goal: Work though R Programing 101 hour-long R tutorial for beginners
# === === === === === === === === === === === === === === === === === ===

### RESOURCES ###
# Colors for R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# Graphing Info: https://r-graph-gallery.com/

# R for Data Science: https://r4ds.hadley.nz/

# Useful Packages
library(tidyverse)
library(ggplot2)


## The Basics of R Programming Overview ##
# 0. Intro + Tidyverse
# 1. Explore
# 2. Clean
# 3. Manipulate
# 4. Describe
# 5. Visualise
# 6. Analyse


# INTRO + TIDYVERSE ------------------------------------------------------
# How to get help when you need it?
?mean
?ChickWeight

# Objects and functions
5+6 # calculator

a <- 5
b <- 6

a + b

sum(a,b)

ages <- c(5,6)
ages
sum(ages)

names <- c("Gabe", "Colin")
friends <- data.frame(names, ages)
View(friends)
str(friends) #gives you structure

# Look at Specific Parts of Data
friends$ages #variable

friends [1,1] #rows, columns
friends [1,]
friends [,1]

# Built in data sets to practice with
data()
View(starwars)

# Installing and using packaaes
install.packages("tidyverse")
library(tidyverse)

## TIDYVERSE ##
# Pipe Operator = %>%  (shift + CNTL + m), basically means and then

starwars %>% # Pipe Operator
  filter(height > 150 & mass <200) %>% # filtering
  mutate(height_in_meters = height/100) %>% # mutate = change, making a new variable here
  select(height_in_meters, mass) %>% # what variables to work with
  arrange(mass) %>% # how to arrange (can use - to invert it)
#  view()
  plot()

#### end ####

# EXPLORE ------------------------------------------------------
# Data structures and types of variables
view(msleep)

glimpse(msleep) #overview of data: names, types of variable
xz
head(msleep) #first 6 rows

class(msleep$name) #what type of data

length(msleep$name) #how many observations

names(msleep) #names of variables

unique(msleep$vore) #unique objects in varible

missing <- !complete.cases(msleep) # !inverts data, complete.cases gives list of which there is no missing data 

msleep[missing,] #list of rows with missing data

#### end ####

# CLEAN ------------------------------------------------------
# Select variables
starwars %>% 
  select(name, height, mass)

starwars %>% 
  select(1:3)

starwars %>% 
  select(ends_with("color")) #selects all variables that end with "color"

# Changing varibale order 
starwars %>% 
  select(name, mass, height, everything())

# Changing variable name
starwars %>% 
  rename("characters" = "name") %>%  #new name first
  head()

# Changing variable type
class(starwars$hair_color)

starwars$hair_color <- as.factor(starwars$hair_color) #change to factor

starwars %>% 
  mutate(hair_color = as.character(hair_color)) %>% 
  glimpse()

# Changing factor levels => default is alphabetical order
df <- starwars
df$sex <- as.factor(df$sex)

levels(df$sex)

df<- df %>% 
  mutate(sex = factor(sex,
                      levels = c("male", "female","hermaphroditic", "none"
                                 )))
levels(df$sex)

# Filter rows
starwars %>% 
  select(mass, sex) %>% 
  filter(mass < 55 &
            sex == "male")

# Recode data
starwars %>% 
  select(sex) %>% 
  mutate(sex = recode(sex,
                      "male" = "man",
                      "female" = "woman")) #Change male and female

# Dealing with missing data
mean(starwars$height) #NA bc of missing data
mean(starwars$height, na.rm = T) # NA remove = True

# Dealing with Duplicates
Names <- c("Peter", "John", "Andrew", "Peter")
Age <- c(22, 33, 44, 22)

friends <- data.frame(Names, Age)
friends

friends %>% 
  distinct() #gives you a data frame that removes duplicates

distinct(friends) #same as above

#### end ####

# MANIPULATE ------------------------------------------------------
# Create of change a variable (mutate)
starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m)

# Conditional change (if_else)
starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m) %>% 
  mutate(tallness =
           if_else(height_m < 1, "short", "tall")) #condition, if met, else

# Reshape data with Pivot wider
library(gapminder) #great dataset
view(gapminder) #rightnow in a long format

data <- select(gapminder, country, year, lifeExp) #same thing as below

data <- gapminder %>% 
  select(country, year, lifeExp) 

wide_data <- data %>% 
  pivot_wider(names_from = year, values_from = lifeExp) # what this is doing is pulling from the "year" column to make new headers for each year, THEN it is filling those with the values for "lifeExp"
view(wide_data)

long_data <- wide_data %>% 
  pivot_longer(2:13,
               names_to = "year",
               values_to = "lifeExp") #basically the reverse, creating new columns
view(long_data)

#### end ####

# DESCRIBE ------------------------------------------------------
view(msleep)

# Range/spread
min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)

# Centrality
mean(msleep$awake)
median(msleep$awake)

# Variance
var(msleep$awake)

# All at once
summary(msleep$awake)

msleep %>% 
  select(awake, sleep_total) %>% 
  summary()

# Summarize your data
msleep %>%  # select your data
  drop_na(vore) %>% #remove missing values
  group_by(vore) %>% #group by type => "vore"
  summarize(Lower = min(sleep_total), #create variable headings = function(variable you want value)
            Average = mean(sleep_total),
            Upper = max(sleep_total),
            Difference = max(sleep_total)-min(sleep_total)) %>% 
  arrange(Average) %>% #put in order by "average" value
  View()

# Create tables

table(msleep$vore) #gives us a count of occurrences of variable

msleep %>% 
  select(vore, order) %>% 
  filter(order %in% c("Rodentia", "Primates")) %>% #saying if in the oder column there is ANY of the following variables, include them
  table()

#### end ####

# VISUALISE ------------------------------------------------------

plot(pressure)

# The grammar of graphics
    # data => what data are you using
    # mapping => using aesthetics
    # geometry => line, barchart, histograms, etc.

# Aesthetics
    # X and Y axis
    # Color, shape, size, etc.


# Bar plots
ggplot(data = starwars,
       mapping = aes(x = gender)) +
  geom_bar()

# Histograms 
starwars %>% #piping data in allows you to do stuff with it BEFORE it gets to the graphic
  drop_na(height) %>% #such as filter out missing data
  ggplot(aes(x = height)) + #autofills in starwars for first argument = data
  geom_histogram()

# Box plots
starwars %>% 
  drop_na(height) %>% 
  ggplot(aes(x = height)) +
  geom_boxplot(fill = "steelblue") +
  theme_bw() +
  labs(title = "Boxplot of Height",
       x = "Height of Characters")

# Density plots
starwars %>% 
  drop_na(height) %>% 
  filter(sex %in% c("male", "female")) %>% 
  ggplot(aes(x = height,
             color = sex,
             fill = sex)) +
  geom_density(alpha = 0.2) + #darkness of fill
  theme_bw()

# Scatter plots
starwars %>% 
  filter(mass < 200) %>% 
  ggplot(aes(x = height,
             y = mass,
             color = sex)) +
  geom_point(size = 5, alpha = 0.5) +
  theme_minimal() +
  labs(title = "Height and Mass by Sex")

# Smoothed model
starwars %>% 
  filter(mass < 200) %>% 
  ggplot(aes(x = height, y = mass, color = sex)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth()+ #draw a smooth linear model over points, 95% standard error
  facet_wrap(~sex) #look at data in different boxes based on sex
  theme_bw() +
  labs(title = "Height and Mass by Sex")
  
#### end ####
  
# Analyze ------------------------------------------------------

## Hypothesis Testing ##
  
# T-test => comparing means of 2 groups
view(gapminder) # test if there is a difference in mean life expectancy between Africa and Europe
  
gapminder %>% 
  filter(continent %in% c("Africa", "Europe")) %>% 
  t.test(lifeExp ~ continent, data = ., # the data = . tells pipe operator to put data here
         altrnative = "two.sided", # these are default so technically don't need to be included
         paired = FALSE)

# ANOVA => comparing means of 3+ groups
gapminder %>% 
  filter(year == 2007) %>% 
  filter(continent %in% c("Americas", "Europe", "Asia")) %>% 
  aov(lifeExp ~ continent, data = .) %>% #aov = anova test
  summary()
  
gapminder %>% 
  filter(year == 2007) %>% 
  filter(continent %in% c("Americas", "Europe", "Asia")) %>% 
  aov(lifeExp ~ continent, data = .) %>% #aov = anova test
  TukeyHSD() %>%  #lets us look at p-vlaue for each pairing
  plot()
  

# Chi Squared gooness of fit test => comparing categorical data
head(iris) 

flowers <- iris %>% 
  mutate(size = cut(Sepal.Length, # break varibale into 3 intervals
                    breaks = 3,
                    labels = c("Small", "Medium", "Large"))) %>% 
  select(Species, size) %>% 
  view()

# Chi Squared goodness of fit => is there an equal proportion of flowers of each size?
flowers %>% 
  select(size) %>% 
  table() %>% 
  chisq.test()

#p-value = 6.673e-07 => reject null, there is a significant difference 

# Chi Squared test of independence => are size and species independent?
flowers %>% 
  table() %>% 
  chisq.test()

#p-value < 2.2e-16 => reject null, significant, cateogries are linked


# Linear model
head(cars, 10)

cars %>% 
  lm(dist ~ speed, data = .) %>% #dependent as function of indepedent variable
  summary()

#variables to pay attention to: Y-intercept, Slope, p value, R2

#### end ####


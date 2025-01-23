# === === === === === === === === === === === === === === === === === === 
# Created by Gabe Veltri on 11/18/2024
# Project: Help
# Goal: This R code contains basic R commands and serves as a refernce for future projects
# === === === === === === === === === === === === === === === === === ===

### RESOURCES ###
# ?_______ #allows you to get information about what a command does

# Colors for R: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# Graphing Info: https://r-graph-gallery.com/

# R for Data Science: https://r4ds.hadley.nz/


#### GETTING STARTED ####

# Working with packages
install.packages() #allows you to install a pacakge permanently
library() #allows you to load up package

# Importing Data
getwd() #tells you working directory
df <- read.csv(file.choose(),header = T) 
sleep <- read.csv(here("data", "sleep_score.csv")) # you can also use the here package which allows you to easily navigate through the directory tree

#### end ####

# === === === === === === === === === === === === === === === === === ===

#### PREPPING DATA ####
# Importing Data
df <- read.csv(file.choose(),header = T)

# Viewing Data
head() #first 6 rows
tail() #last 6 rows
view() #all data in separate tab/table

# Extracting Data
my_data[1,1] #_____ = data set, 1st number = row, 2nd number = column
my_data[,1] #since the row is blank it just gives you the whole cloumn
my_data$variable #adding a $ extracts one variable to look at

NAME <- subset(df, variable header == name of variable)
EX <- subset(Intein_df, Pglo_.1or.0 == 1)

#### end ####

# === === === === === === === === === === === === === === === === === ===

#### MAKING GRAPHS ####
# Histogram: col = color
hist(DATA$Variable on X-axis, col = "COLOR")

# Scatter PLot: pch = shape, cex = size
plot(DATA$X, DATA$y, pch = 19)

# Displaying Graphs
par(mfrow=c(2,1)) #display multiple graphs at the same time (# rows, #column)

#### end ####

# === === === === === === === === === === === === === === === === === ===

#### MANIPULATING DATA ####
str() #shows the structure of data AKA what types of data do you have
friends$height <- as.factor(friends$height) #changes the variable height within data set friends to a factor

levels() # shows you what levels a variable is ordered
friends$height <- factor(friends$height,
                         levels = c("Short","Medium","Tall")) #allows you to change the order of data using levels

Combined_Groups <- data.frame(cbind(Group1, Group2, Group3)) #combine groups into one

#### end ####

# === === === === === === === === === === === === === === === === === ===

#### CALCULATING MEANS ####
#Example 1
data(iris)
aggregate(x= iris$Sepal.Length, by = list(iris$Species), FUN = mean)

#Example 2
library(dplyr)
iris %>%                                        # Specify data frame
  group_by(Species) %>%                         # Specify group indicator
  summarise_at(vars(Sepal.Length),              # Specify column
               list(name = mean))               # Specify function

# Example 3
library(Rmisc)
summarySE(iris, measurevar="Sepal.Length", groupvars=c("Species"))

#### end ####

# === === === === === === === === === === === === === === === === === ===

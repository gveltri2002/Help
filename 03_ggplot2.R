# === === === === === === === === === === === === === === === === === === 
# Created by Gabe Veltri on 11/18/2024
# Project: Help
# Goal: Help on using ggplot2
# === === === === === === === === === === === === === === === === === ===

library(ggplot2)

### GROUPED BOXPLOT ###

# create a data frame
variety=rep(LETTERS[1:7], each=40)
treatment=rep(c("high","low"),each=20)
note=seq(1:280)+sample(1:150, 280, replace=T)
data=data.frame(variety, treatment ,  note)

# grouped boxplot
ggplot(data, aes(x=variety, y=note, fill=treatment)) + 
  geom_boxplot()

# One box per treatment
ggplot(data, aes(x=variety, y=note, fill=treatment)) + 
  geom_boxplot() +
  facet_wrap(~treatment)

# one box per variety
ggplot(data, aes(x=variety, y=note, fill=treatment)) + 
  geom_boxplot() +
  facet_wrap(~variety, scale="free")




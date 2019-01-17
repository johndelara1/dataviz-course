miami <- read_csv('https://journalismcourses.org/courses/DE0618/SchoolsMiamiDade.csv')
# write_csv(miami, "data/miami.csv", na="") # Data backup
# more data: https://journalismcourses.org/courses/DE0618/Module_2_%20Excel_Downloads.pdf

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# View of school's grades (count)
ggplot(miami, aes(x=SchoolGrade)) +
  geom_bar(fill="skyblue") +
  theme_minimal()

# View of school's grades (percent)
ggplot(miami, aes(x=SchoolGrade)) +
  geom_bar(aes(y = (..count..)/sum(..count..)*100), fill="skyblue") +
  ylab('percent') +
  theme_minimal()

# View of reading scores (reading)
ggplot(miami, aes(x=Reading2013)) +
  geom_histogram(fill="skyblue") +
  theme_minimal()

# View of reading scores (math)
ggplot(miami, aes(x=Math2013)) +
  geom_histogram(fill="skyblue") +
  theme_minimal()

# Scatter plot of math x reading
ggplot(miami) +
  geom_point(aes(x=Math2013, y=Reading2013)) + # to-do: discover how to color differently x and y axis
  facet_wrap(~BoardDistrict) + # divides by districts
  theme_minimal()

# !! we're visualizing relationships, not causual connections. low income families don't lead to low rating schools
# !! talk to experts to discover these casual connections play in the real world
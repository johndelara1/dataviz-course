gap <- read_csv('https://journalismcourses.org/courses/DE0618/Gapminder2012.csv')
# write_csv(gap, "data/gapminder2012.csv", na="") # Data backup

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# to-do: compare adressess to Miami district's income from the Census https://youtu.be/BTrRbS_-Ohg?list=PL0tDk-f4v1ugEg01UdiXB9QL0AaSSsaYs&t=741

# to-do: map with fertility rate per country https://youtu.be/A_0e6SewtTM?list=PL0tDk-f4v1ugEg01UdiXB9QL0AaSSsaYs&t=190
# world shape file by country: data/world/
options(device="X11")
X11.options(type="cairo")
library(sf)

ggplot(st_read('data/world/TM_WORLD_BORDERS-0.3.shp')) +
  geom_sf()

# continue course: how to use iNZight https://www.youtube.com/watch?v=ZVh7rPvvUGI&index=20&list=PL0tDk-f4v1ugEg01UdiXB9QL0AaSSsaYs
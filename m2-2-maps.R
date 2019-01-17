gap <- read_csv('https://journalismcourses.org/courses/DE0618/Gapminder2012.csv')
world <- st_read('data/world/TM_WORLD_BORDERS-0.3.shp')
# write_csv(gap, "data/gapminder2012.csv", na="") # Data backup

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggmap)
library(tigris)
options(tigris_class = "sf")

# to-do: compare adressess to Miami district's income from the Census https://youtu.be/BTrRbS_-Ohg?list=PL0tDk-f4v1ugEg01UdiXB9QL0AaSSsaYs&t=741
#miami <- read_csv('https://journalismcourses.org/courses/DE0618/SchoolsMiamiDade.csv') %>% 
#  filter(!BoardDistrict %in% c('(0)', '()')) # fixes data
#
#miami_city <- tracts(state = '12', county = c('086'), cb=T)

# Scatter plot of math x reading
ggplot(miami) +
  geom_point(aes(x=Math2013, y=Reading2013)) + # to-do: discover how to color differently x and y axis
  facet_wrap(~BoardDistrict) + # divides by districts
  theme_minimal()

# world shape file by country: data/world/
options(device="X11")
X11.options(type="cairo")
library(sf)

world$NAME <- str_replace_all(world$NAME, c("United States"="United States of America", "Russia"="Russian Federation", "Hong Kong"="Hong Kong China",
                                            "Korea, Democratic People's Republic of"="North Korea")) # fixing (some of) incomplete data

gap_world <- full_join(gap, world, by=c("Country"= "NAME")) # incomplete data because 

# fertility rate per country
ggplot(gap_world) +
  geom_sf(aes(fill=ChildrenPerWoman)) +
  scale_fill_viridis_c()
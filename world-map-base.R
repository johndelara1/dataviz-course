# loading data all over again
library(readr)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggmap)
library(tigris)
options(tigris_class = "sf")

# world shape file by country: data/world/
options(device="X11")
X11.options(type="cairo")
library(sf)

gap <- read_csv('https://journalismcourses.org/courses/DE0618/Gapminder2012.csv')
world <- st_read('data/world/TM_WORLD_BORDERS-0.3.shp')
# write_csv(gap, "data/gapminder2012.csv", na="") # Data backup

# fixing (some of) incomplete data
world$NAME <- str_replace_all(world$NAME, c("United States"="United States of America", "Russia"="Russian Federation", "Hong Kong"="Hong Kong China",
                                            "Korea, Democratic People's Republic of"="North Korea", "Burma"="Myanmar",
                                            "Viet Nam"="Vietnam", "Iran (Islamic Republic of)"="Iran", "Libyan Arab Jamahiriya"="Libya"))

world[84, "NAME"]="Iran" # for some reason Iran's row not changing with str_replace_all so we're changing manually with row number

gap_world <- full_join(gap, world, by=c("Country"= "NAME")) # still incomplete data because both datasets list different amount of countries 
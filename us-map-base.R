library(readr)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(sf)
library(tigris)
options(tigris_class = "sf")

# If you're a Mac user, download Quartz and run options below. More info: http://learn.r-journalism.com/en/mapping/static_maps/static-maps/
options(device = "X11")
X11.options(type = "cairo")

# loading county data
counties_data <- read_csv("https://journalismcourses.org/courses/DE0618/CountyData.csv")
# write_csv(county, "data/county.csv", na="") # Data backup

# fix states's name
counties_data$State <- str_replace_all(counties_data$State, c("Alabama"="AL", "Alaska"="AK", "Arizona"="AZ", "Arkansas"="AR",
                                                  "California"="CA", "Colorado"="CO", "Connecticut"="CT", "Delaware"="DE", "Florida"="FL"))

us <- states(cb=T)
counties_map <- counties(cb=T)
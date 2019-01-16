library(readr)
library(stringr)
library(dplyr)
library(tidyr)
library(ggplot2)

country <- read_csv('https://journalismcourses.org/courses/DE0618/CountyData.csv')
# write_csv(country, "data/country.csv", na="") # Data backup

summary(country$`C Income/Capita`) # Summary (video 3)

# Exporing correlations
ggplot(country, aes(x=`C Income/Capita`, y=College2014)) +
  geom_point(aes(color=Region)) + # Color by region (video 7)
  theme_minimal() +
  stat_smooth(se=F) + # Displays correlation in plot / se=F hides confidence level (video 8)
  facet_wrap(~Region) # Create different plots for different regions (video 5)

cor(x=country$`C Income/Capita`, y=country$College2014, use="complete.obs") # correlation (number) / use="complete.obs" removes NAs (video 8)

# maps (video 9)
library(tigris)
options(tigris_class = "sf")

# If you're a Mac user, download Quartz and run options below. More info: http://learn.r-journalism.com/en/mapping/static_maps/static-maps/
#options(device = "X11")
#X11.options(type = "cairo")

us <- states(cb=T) # Download US states' shape file using library tigris
country_states <- country %>% mutate(StateName=str_split(country$CountyState, ", ", simplify=T)[,-1]) %>%  # Create proper State column to join with map data
  group_by(StateName) %>% summarize(income=sum(`C Income/Capita`))

# Fix states's name
country$State <- str_replace_all(country$State, c("Alabama"="AL", "Alaska"="AK", "Arizona"="AZ", "Arkansas"="AR",
                                                  "California"="CA", "Colorado"="CO", "Connecticut"="CT", "Delaware"="DE", "Florida"="FL"))

country <- country %>% select(State, `C Income/Capita`, College2014) # Select data we want

us_country <- left_join(country, us, by=c("State"= "STUSPS")) # Join map data to other data

# Plot US map using ggplot + sf
ggplot(us_country) + 
  geom_sf(aes(fill=College2014)) +
  scale_fill_viridis_c() +
  coord_sf(xlim=c(-67, -125), ylim=c(23, 50)) # Rough cut of US states (minus Hawaii and Alaska)
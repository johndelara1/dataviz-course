source('world-map-base.R')

miami <- read_csv('https://journalismcourses.org/courses/DE0618/SchoolsMiamiDade.csv')
# write_csv(miami, "data/miami.csv", na="") # Data backup
# more data: https://journalismcourses.org/courses/DE0618/Module_2_%20Excel_Downloads.pdf

# cleaning up miami board district data
miami <- miami %>% filter(!BoardDistrict %in% c('()', '(0)'))

# Scatter plot of math x reading in Miami
ggplot(miami) +
  geom_point(aes(x=Math2013, y=Reading2013)) + # to-do: discover how to color differently x and y axis
  facet_wrap(~BoardDistrict) + # divides by districts
  theme_minimal()

# fertility rate per country
ggplot(gap_world) +
  geom_sf(aes(fill=ChildrenPerWoman)) +
  scale_fill_viridis_c()
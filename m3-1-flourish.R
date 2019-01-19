source('world-map-base.R')
  
# Module 3, Class 3: Basic World Map / custom color scale

ggplot(gap_world) +
  geom_sf(aes(fill=ChildrenPerWoman), color="white") + # makes countries's borders white
  #scale_fill_gradient2(low="blue4", mid="white", high="red", midpoint=4) + # diverging scale
  scale_fill_gradient(low="#ffcd9a", high="#f15409", breaks=c(1, 5, 6, 7, 8)) + # custom scale breaks
  guides(fill = guide_colourbar()) +
  theme_minimal()

# Module 3, Class 5: Scatter Plot
ggplot(gap) +
  geom_point(aes(x=ChildrenPerWoman, y=LifeExpectancy, size=Populationtotal, color=Region,  alpha=.9)) +
  xlab('Fertility rate') + # Change x, y legend
  ylab('Life Expectancy') +
  guides(size=F, alpha=F) + # Hides size/alpha legend
  scale_size(range=c(2,14)) + # Resize bubbles' size
  theme_minimal() +
  theme(axis.text=element_text(size=13), # Resize text
        legend.text=element_text(size=13),
        legend.position = 'bottom') # Position legend on bottom

# Module 3, Class 6: Scatter Plot + facets
gap_all <- read_csv('https://journalismcourses.org/courses/DE0618/GapminderAllyears.csv') # Gapminder all years
# write_csv(gap_all, "data/gap_all.csv", na="") # Data backup

# facet by year
ggplot(gap_all) +
  geom_point(aes(x=ChildrenPerWoman, y=LifeExpectancy, size=Populationtotal, color=Region,  alpha=.9)) +
  xlab('Fertility rate') + # Change x, y legend
  ylab('Life Expectancy') +
  guides(size=F, alpha=F) + # Hides size/alpha legend
  scale_size(range=c(2,14)) + # Resize bubbles' size
  theme_minimal() +
  theme(axis.text=element_text(size=13), # Resize text
        legend.text=element_text(size=13),
        legend.position = 'bottom') + # Position legend on bottom
  facet_wrap(~Year)

# continues in m3-2-counties.R
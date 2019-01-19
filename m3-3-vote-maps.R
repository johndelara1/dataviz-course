source('us-map-base.R')

# creating rounded percentage columns with dem & rep votes
counties_data <- counties_data  %>% mutate(PerDemROUND=PercentageDemocratic2016*100,
                                PerRepROUND=PercentageRepublican2016*100,
                                DemOrRepPERCENT=ifelse(PerRepROUND>PerDemROUND, PerRepROUND, -PerDemROUND)) # create ifelse statement for winner column

## since counties_data is using deprecated FIPS code (different from counties_map), we need to join the two datasets by county name
#install.packages('totalcensus')
#library(totalcensus)

# creating county column in counties_map
#counties_map$COUNTY <- convert_fips_to_names(FIPs=counties_map$COUNTYFP, states=convert_fips_to_names(counties_map$STATEFP), geo_header = "COUNTY")

# creating county column in counties_data
#counties_data$COUNTY <- str_split(counties_data$CountyState, ", ", simplify=T)[,1]

# joining two data frames into a single one
#counties <- left_join(select(counties_data, COUNTY, DemOrRepPERCENT), counties_map, by="COUNTY")

# IMPORTANT: won't plot county map because it's too slow on R (even with X11 cairo). if you know a faster way, hit me up
#ggplot(counties) + 
#  geom_sf(color="white")

## scatter plot of republican votes
ggplot() + 
  geom_sf(data=us, color="white") + # loads map data
  geom_point(data=counties_data, aes(x=Longitude, y=Latitude, size=VoteRepublican2016, alpha=.6), color="red2") + # loads republican vote
  guides(size=F, alpha=F) + # Hides size/alpha legend
  scale_size(range=c(-1,18)) + # negative number on scale hides pretty low values
  coord_sf(xlim=c(-67, -125), ylim=c(23, 50)) + # Rough cut of US states (minus Hawaii and Alaska)
  xlab('') + # Change x, y legend
  ylab('') +
  theme_minimal() +
  ggsave("export/2016-republican-votes.png", width=16, height=9)

## scatter plot of democratic votes
ggplot() + 
  geom_sf(data=us, color="white") + # loads map data
  geom_point(data=counties_data, aes(x=Longitude, y=Latitude, size=VoteDemocratic2016, alpha=.6), color="royalblue") + # loads democratic vote
  guides(size=F, alpha=F) + # Hides size/alpha legend
  scale_size(range=c(-1,18)) + # negative number on scale hides pretty low values
  coord_sf(xlim=c(-67, -125), ylim=c(23, 50)) + # Rough cut of US states (minus Hawaii and Alaska)
  xlab('') + # Change x, y legend
  ylab('') +
  theme_minimal() +
  ggsave("export/2016-democratic-votes.png", width=16, height=9)
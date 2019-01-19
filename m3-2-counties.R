source('us-map-base.R')

# democratic & republican vote on 2016 elections
ggplot() + 
  geom_sf(data=us, color="white") + # loads map data
  geom_point(data=counties_data, aes(x=Longitude, y=Latitude, size=VoteDemocratic2016, alpha=.6), color="royalblue") + # loads democratic vote
  geom_point(data=counties_data, aes(x=Longitude, y=Latitude, size=VoteRepublican2016, alpha=.6), color="red2") + # loads republican vote
  guides(size=F, alpha=F) + # Hides size/alpha legend
  scale_size(range=c(-1,24)) + # negative number on scale hides pretty low values
  coord_sf(xlim=c(-67, -125), ylim=c(23, 50)) + # Rough cut of US states (minus Hawaii and Alaska)
  xlab('') + # Change x, y legend
  ylab('') +
  theme_minimal() +
  ggsave("export/2016-vote-map.png", width=16, height=9)

# continues on m3-3-vote-maps.R
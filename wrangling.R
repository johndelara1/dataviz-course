library(readr)
library(dplyr)
library(tidyr)

# You can also use install.packages('wbstats') to get data straight from World Bank

# Wide to long format, removes unnecessary columns, filter out 2015-2017 that don't have emissions
co2 <- read_csv('data/co2.csv', skip=4) %>% gather("year", "emissions", "1960":"2017") %>%
  select(country=`Country Name`, code=`Country Code`, year, emissions) %>% 
  filter(!year %in% c('2015', '2016', '2017'))

# Replace commas
#str_replace_all(co2$`Country Name`, ",", "")

# Read population data
pop <- read_csv('data/population.csv', skip=4) %>% gather("year", "population", "1960":"2017") %>%
  select(country=`Country Name`, code=`Country Code`, year, population) %>% 
  filter(!year %in% c('2015', '2016', '2017'))

# CO2 emissions per capita + export
co2xpop <- left_join(co2, pop, by=c("country", "code", "year")) %>%
  mutate(year=as.numeric(year), emissions=as.numeric(emissions), # Converte para número
         co2xpop=emissions/population*1000) %>% 
  write_csv("export/co2xpop.csv", na="")

# Brazil's  emission

library(ggplot2)

ggplot(data=co2xpop %>% filter(code=="BRA"), aes(x=year, y=co2xpop)) +
  geom_bar(stat="identity", fill="skyblue") +
  theme_minimal() +
  xlab('Ano (1960-2013)') +
  ylab('Emissões (kt)') +
  labs(
    title='Emissões de CO2 per capita no Brasil',
    caption='Fonte: Banco Mundial'
  )

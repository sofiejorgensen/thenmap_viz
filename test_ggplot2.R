#===============================================================================
# Test to create maps with ggplot2
#===============================================================================
# Packages
library(ggplot2)
library(dplyr)
require(maps)
require(viridis)
theme_set(
  theme_void()
)

# World map data
world_map <- map_data("world")
ggplot(world_map, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill="lightgray", colour = "black")

# Select countries
country <- c(
  "Sweden", "Norway", "Finland", "Denmark", "Iceland"
)
# Retrievethe map data
country_map <- map_data("world", region = country)

# Compute the centroid as the mean longitude and lattitude
# Used as label coordinate for country's names
region_data <- country_map %>%
  group_by(region) %>%
  summarise(long = mean(long), lat = mean(lat))




ggplot(country_map, aes(x = long, y = lat)) +
  geom_polygon(aes( group = group, fill = region))+
  geom_text(aes(label = region), data = region_data,  size = 3, hjust = 0.5)+
  scale_fill_viridis_d()+
  theme_void()+
  theme(legend.position = "none")



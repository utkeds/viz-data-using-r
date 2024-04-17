library(ozmaps)
library(sf)

oz_states <- ozmaps::ozmap_states
oz_states

ggplot(oz_states) + 
  geom_sf() + 
  coord_sf()

ggplot(oz_states, aes(fill = NAME)) + 
  geom_sf() + 
  coord_sf()

ggplot(oz_states, aes(fill = NAME)) + 
  geom_sf() + 
  coord_sf()

ggplot(oz_states, aes(fill = NAME)) + 
  geom_sf(color = "white") + 
  coord_sf() +
  theme_void() +
  theme(legend.position = "none")

ggplot(oz_states, aes(fill = NAME)) + 
  geom_sf(color = "white") + 
  geom_sf_text(aes(label = NAME), label.padding = unit(1, "mm")) +
  theme_void() +
  theme(legend.position = "none")

oz_pop <- readr::read_csv("week-13/oz_pop.csv")
colnames(oz_pop)

oz_dat <- left_join(oz_states, oz_pop, by = join_by(NAME == `State/Territory`))

ggplot(oz_dat, aes(fill = NAME)) + 
  geom_sf(color = "white") + 
  geom_sf_text(aes(label = NAME), label.padding = unit(1, "mm")) +
  theme_void() +
  theme(legend.position = "none")

library(viridis)

ggplot(oz_dat, aes(fill = Population)) + 
  geom_sf(color = "white") + 
  theme_void() +
  theme(legend.position = "none")

ggplot(oz_dat, aes(fill = Population)) + 
  geom_sf(color = "white") + 
  geom_point(aes(x = long_cap, y = lat_cap),
             size = 3) +
  scale_fill_viridis(option = "magma") +
  theme_void() +
  theme(legend.position = "none")

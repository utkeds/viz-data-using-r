library(ozmaps)
library(sf)
library(ggplot2)
library(dplyr)

oz_states <- ozmaps::ozmap_states

ggplot(oz_states, aes(fill = NAME)) +
  geom_sf(color = "white") +
  coord_sf() +
  geom_sf_label(aes(label = NAME)) +
  theme_void() +
  theme(legend.position = "none")

oz_pop <- readr::read_csv("week-13/oz_pop.csv")

oz_states

oz_dat <-
  left_join(oz_states, oz_pop, by = join_by("NAME" == `State/Territory`))

ggplot(oz_dat, aes(fill = Population)) +
  geom_sf(color = "white") +
  theme_void()

library(viridis)

ggplot(oz_dat, aes(fill = Population)) +
  geom_sf(color = "white") +
  geom_point(aes(x = long_cap, y = lat_cap), size = 3) +
  scale_fill_viridis(option = "magma", labels = scales::comma) +
  theme_void()

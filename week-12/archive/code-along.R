library(ozmaps)
library(sf)
library(tidyverse)

#Oz maps gets your geometry (sf object)
oz_states <- ozmaps::ozmap_states

# Plotting the map
ggplot(oz_states, aes(fill = NAME)) +
  geom_sf(color = "white") +
  geom_sf_label(aes(label = NAME)) +
  theme_void() +
  theme(legend.position = "none")

#Plotting without the two odd labels
oz_states |>
  slice(-8,-9) |>
  ggplot(aes(fill = NAME)) +
  geom_sf(color = "white") +
  geom_sf_label(aes(label = NAME)) +
  theme_void() +
  theme(legend.position = "none")

# Reading in a csv of the populations and capital for each state
oz_pop <- readr::read_csv("week-13/oz_pop.csv")

oz_states

# Look at both oz_pop and oz_states to find common variable to join on

oz_dat <-
  left_join(oz_states, oz_pop, by = join_by("NAME" == `State/Territory`))

ggplot(oz_dat, aes(fill = Population)) +
  geom_sf(color = "white") +
  theme_void()

library(viridis)

ggplot(oz_dat, aes(fill = Population)) +
  geom_sf() +
  geom_point(aes(x = long_cap, y = lat_cap), size = 4, shape=21, color = "white", fill="black") +
  scale_fill_viridis(option = "magma", labels = scales::comma) +
  theme_void()

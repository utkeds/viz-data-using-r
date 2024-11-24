library(tidyverse)
library(rgbif)
library(rnaturalearth)
library(ggplot2)
theme_set(theme_minimal())

cat <- rgbif::occ_data(scientificName = 'Felis catus')

cat_dat <- cat$data
glimpse(cat_dat)

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)

ggplot(data = world) +
  geom_sf()

glimpse(world)
# country under name

cat_dat |> select(country)

cat_dat_sum <-
  cat_dat |>
  group_by(country) |>
  summarize(country_count = n()) |>
  ungroup() |>
  mutate(
    country = case_when(
      country == "Russian Federation" ~ "Russia",
      country == "United Kingdom of Great Britain and Northern Ireland" ~ "United Kingdom",
      country == "Korea, Republic of" ~ "Korea",
      .default = country
    )
  )

cat_world <-
  left_join(world, cat_dat_sum, by = join_by(name_long == country))

ggplot(data = cat_world) +
  geom_sf(aes(fill = country_count),
          linewidth = 0.1,
          color = "white")

ggplot(data = cat_world) +
  geom_sf(aes(fill = country_count,
              label = name),
          linewidth = 0.1,
          color = "white") +
  geom_point(data = cat_dat,
             aes(x = decimalLongitude,
                 y = decimalLatitude),
             size = 0.1) -> p

ggplotly(p)

library(leaflet)

pal <- colorBin("viridis",
                bin = 3,
                domain = cat_world$country_count)

leaflet(cat_world) %>%
  # Choose another tile
  addProviderTiles(providers$Esri.NatGeoWorldMa) %>%
  setView(lng = -118.259,
          lat = 34.0507666,
          zoom = 6) %>%
  addPolygons(fillColor = ~ pal(country_count),
              label = ~ country_count) %>%
  addCircleMarkers(data = cat_dat,
                   ~ decimalLongitude,
                   ~ decimalLatitude,
                   popup = "CAT!")

labels <- paste0("<strong>Number of cats spotted: </strong><br/>",
                 cat_world$country_count) %>% lapply(htmltools::HTML)

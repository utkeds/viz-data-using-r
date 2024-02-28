library(tidyverse)
library(scales)

tidykids <- read_csv("week-5/tidykids.csv")

tidykids <- tidykids %>% 
  select(-...1)

tidykids %>% 
  filter(state == "Alaska", year == 2016) %>% 
  ggplot(aes(x = reorder(variable, inf_adj), y = inf_adj)) +
  geom_col() + 
  scale_y_continuous(label = dollar_format()) +
  coord_flip() 

tidykids %>% 
  filter(state %in% c("Michigan", "Wisconsin", "Minnesota", "Illinois")) %>% 
  filter(variable == "PK12ed") %>% 
  filter(year >= 2012) %>% 
  mutate(year = as.character(year)) %>% 
  ggplot(aes(x = state, y = inf_adj, fill = year)) +
  geom_col(position = "dodge") +
  scale_fill_brewer(type = "seq") +
  theme_fivethirtyeight()

# tidykids %>% 
#   filter(variable == "PK12ed") %>% 
#   filter(year >= 2012) %>% 
#   ggplot(aes(x = year, y = inf_adj_perchild)) +
#   geom_col(position = "dodge") +
#   facet_wrap(~state)

starwars_to_viz <- starwars %>% 
  mutate(eye_color = tools::toTitleCase(eye_color)) %>% 
  mutate(eye_color = as.factor(eye_color)) %>% 
  mutate(eye_color = fct_lump_min(eye_color, min = 4)) %>% 
  count(eye_color)

starwars_to_viz %>% 
  ggplot(aes(x = reorder(eye_color, n), y = n)) +
  geom_col(fill = "#1e81b0") +
  theme_minimal() +
  labs(x = "Eye Color", y = "Number of Characters",
       title = "The Eye Colors of Starwars Characters",
       caption = "'Other' includes eye colors that appeared 3 or fewer times")

tidykids %>% 
  filter(variable == "PK12ed") %>% 
  filter(state %in% c("Michigan", "Wisconsin", "Minnesota", "Illinois")) %>% 
  mutate(inf_adj_perchild = round(inf_adj_perchild, 0)) %>% 
  ggplot(aes(x = year, y = state, label = inf_adj_perchild)) +
  geom_tile() +
  geom_text(color = "white")

tidykids %>% 
  filter(variable == "highered") %>% 
  ggplot(aes(x = raw)) +
  geom_histogram(binwidth = 100)

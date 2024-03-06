library(readxl) # install.packages("readxl")
library(tidyverse)

compiled <- read_excel("US-News-Rankings-Universities-2020.xlsx", 
                       sheet = 1, skip = 1)

compiled <- compiled %>% 
  janitor::clean_names()

compiled %>% 
  glimpse()

compiled_long <- compiled %>% 
  pivot_longer(cols = x2023:x1984, names_to = "year", values_to = "ranking")

compiled_long <- compiled_long %>% 
  mutate(year = str_sub(year, start = 2),
         year = as.numeric(year))

library(ggpubr)

compiled_long %>% 
  filter(university_name == "Cornell University") %>% 
  ggplot(aes(x = year, y = ranking)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "salmon") +
  stat_cor() 

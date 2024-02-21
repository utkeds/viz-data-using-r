# step 1

library(tidyverse)
library(here)

# this was the first approach that came up (say the why in comments, not the how)
tk <- read_csv(here("week-4", "tidykids.csv")) # matthew's approach
# tk <- read_csv("week-4/tidykids.csv") # check wd approach
# tidykids <- read_csv("week-4/tidykids.csv") # nagham's approach
# file_path <- "/Users/wangwei/Downloads/tidykids.csv"
# tidykids <- read.csv(file_path) # wei's approach
# tidykids <- read.csv("/Users/wangwei/Downloads/tidykids.csv") # wei's all-in-one approach
# setwd() # chulin's approach
# tk <- read_csv("tidykids.csv")

# step 2
tk %>% 
  select(state, year, raw, variable) %>% 
  filter(state == "Tennessee") %>% 
  filter(variable == "PK12ed") %>% 
  arrange(year)

# step 3
tk %>% 
  filter(state == "Tennessee" | state == "Florida") %>% count(state)

tk %>% 
  filter(state == "Tennessee" | state == "Florida") # cody solution

tk_tn_fl_highered <- tk %>% 
  select(-...1) %>% 
  filter(state %in% c("Tennessee", "Florida")) %>% 
  rename(spending_category = variable) %>% 
  filter(spending_category == c("highered")) %>% 
  filter(year >= 2010) %>% 
  arrange(desc(inf_adj_perchild))

# step 4
tk %>% 
  count(variable) %>% View()

spending_co_lib <- tk %>% 
  select(state, year, raw, variable) %>% 
  filter(state == "Colorado") %>% 
  filter(variable == "lib") %>% 
  rename(raw_spending = raw)

ggplot(spending_co_lib, aes(x = year, y = raw_spending)) +
  geom_point() +
  geom_line() +
  labs(y = "Raw Spending ($)",
       x = "Year",
       title = "Spending in Colorado on Libraries (1997-2016)",
       subtitle = "Spending went up, then plateaued and never exceeded 2010 spending") +
  theme_minimal()

spending_co_md_lib <- tk %>% 
  select(state, year, inf_adj_perchild, variable) %>% 
  filter(state %in% c("Tennessee", "Georgia", "North Carolina")) %>% 
  filter(variable == "PK12ed") %>% 
  rename(inf_adj_spending = inf_adj_perchild)

ggplot(spending_co_md_lib, aes(x = year, 
                               y = inf_adj_spending,
                               group = state,
                               color = state,
                               label = inf_adj_spending)) +
  geom_point() +
  # geom_text() +
  # geom_line() +
  geom_smooth(se = FALSE) +
  labs(y = "Spending Per Child, $1,000s, inf. adjusted",
       x = "Year",
       title = "Spending in CO, MD and ID on Libraries (1997-2016)",
       subtitle = "CO spend the most in the mid-2000s, through 2016") +
  theme_minimal() +
  scale_color_brewer("", type = "qual")


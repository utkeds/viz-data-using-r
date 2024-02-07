library(tidyverse)
c <- read_csv("~/Downloads/Interest in course questions (Responses) - Form Responses 1 (1).csv")

c %>% 
  slice(12) %>% 
  gather(key, val) %>% 
  slice(-1) %>% 
  mutate(val = as.numeric(val)) %>% 
  arrange(desc(val)) %>% 
  mutate(key = str_sub(key, start = 72, end = -2)) %>% 
  mutate(key = fct_inorder(key)) %>% 
  ggplot(aes(x = key, y = val)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 45))

ggsave("class-interests.png", width = 10, height = 10)

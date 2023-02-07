data_original <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-13/datasaurus.csv')

data <- data_original %>% 
  arrange(dataset) %>%
  group_by(dataset) %>%
  mutate(dataset = as.factor(dataset),
         dataset = as.numeric(dataset))
         dataset = LETTERS[dataset])

write.csv(data, "Week 6/week_6_data.csv", row.names = FALSE)

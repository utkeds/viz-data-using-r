library(readxl) # install.packages("readxl")
library(tidyverse)

us_news <- read_excel("US-News-Rankings-Universities-2020.xlsx", sheet = "2020 All", skip = 2)

us_news <- us_news %>% 
  janitor::clean_names()

us_news <- us_news %>% 
  mutate_at(vars(x2020_rank, overall_score:percent_of_classes_of_50_or_more_students,
                 student_faculty_ratio_footnote, selectivity_rank,
                 sat_act_25th_75th_percentile_footnote:average_alumni_giving_rate), as.numeric)

us_news <- us_news %>% 
  separate(sat_act_25th_75th_percentile, into = c("sat_act_25th_percentile", 
                                                  "sat_act_75th_percentile")) %>% 
  mutate(sat_act_25th_percentile = as.numeric(sat_act_25th_percentile),
         sat_act_75th_percentile = as.numeric(sat_act_75th_percentile))

us_news <- us_news %>% 
  separate(student_faculty_ratio, into = c("student_faculty_ratio", "one")) %>% 
  mutate(student_faculty_ratio = as.numeric(student_faculty_ratio)) %>% 
  select(-one, -contains("footnote"))

us_news %>% 
  glimpse()

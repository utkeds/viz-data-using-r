library(readxl)
library(tidyverse)

us_news <- read_csv("US-News-Rankings-Universities-2020.csv", skip = 3)

us_news <- us_news %>% janitor::clean_names()

remove_percentage <- function(x) {
  str_replace(x, "%", "") %>% 
    as.numeric()
}

us_news <- us_news %>% 
  mutate(average_first_year_retention_rate = remove_percentage(average_first_year_retention_rate),
         predicted_graduation_rate = remove_percentage(predicted_graduation_rate),
         actual_graduation_rate = remove_percentage(actual_graduation_rate),
         pell_gradrate = remove_percentage(pell_gradrate),
         percent_of_classes_under_20 = remove_percentage(percent_of_classes_under_20),
         percent_of_classes_of_50_or_more_students = remove_percentage(percent_of_classes_of_50_or_more_students),
         first_year_students_in_top_10_percent_of_high_school_class = remove_percentage(first_year_students_in_top_10_percent_of_high_school_class),
         acceptance_rate = remove_percentage(acceptance_rate),
         average_alumni_giving_rate = remove_percentage(average_alumni_giving_rate))


us_news <- us_news %>% 
  separate(sat_act_25th_75th_percentile, into = c("sat_act_25th_percentile", 
                                                  "sat_act_75th_percentile")) %>% 
  mutate(sat_act_25th_percentile = as.numeric(sat_act_25th_percentile),
         sat_act_75th_percentile = as.numeric(sat_act_75th_percentile))

us_news <- us_news %>% 
  separate(student_faculty_ratio, into = c("student_faculty_ratio", "one")) %>% 
  select(-one, -contains("footnote"))

us_news <- us_news %>% 
  select(-x2020_rank) %>% 
  mutate_at(vars(overall_score:average_alumni_giving_rate), as.numeric)

us_news %>% 
  glimpse()

us_news %>% 
  write_csv("us-news-rankings-2020-processed.csv")

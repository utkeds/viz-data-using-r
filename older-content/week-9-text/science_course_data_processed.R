# this data is from the DSIEUR https://github.com/data-edu/dataedu pacakge and has been modified for this course


data <- read_csv("https://github.com/data-edu/dataedu/raw/master/data-raw/wt01_online-science-motivation/processed/s12-course-data.csv")

science_course_data <- data %>%
  select(-Grade_Category) %>%
  janitor::clean_names() %>%
  rename(user_id = bb_user_pk)

write.csv(science_course_data, file="science_course_data.csv", row.names = FALSE)

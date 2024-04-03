# Code Along 1

library(dplyr)
library(tidyr)
library(dsbox)
library(ggplot2)
library(MetBrewer)

staff <- dsbox::instructors

staff_long <- staff %>%
  pivot_longer(cols = -year, names_to = "faculty_type") %>%
  mutate(date = as.Date(paste0(year, "-01-01")))

staff_long

p <- 
  staff_long %>%
  ggplot(aes(x = year, y = value, color = faculty_type)) +
  geom_line(linewidth = 1.4) +
  labs(title = "Instructional staff employment trends",
       caption = "Source: American Association of University Professors (AAUP)",
       y = "Proportion") +
  theme_minimal() +
  theme(legend.position = "bottom",
        axis.title.x = element_blank())

p

p +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(size = 14, color = "#C6473E"),
    axis.text.y = element_text(size = 14, color = "#C6473E")
  ) +
  scale_y_continuous(limits = c(0, 100)) +
  scale_color_manual(
    values = met.brewer("Hokusai1"),
    labels = c(
      "full_time_non_tenure_track" = "Full Time Non-Tenure Track",
      "full_time_tenure_track" = "Full Time Tenure Track",
      "full_time_tenured" = "Full Time Tenured",
      "grad_student" = "Grad Student",
      "part_time" = "Part Time"
    )
  ) -> p2

# Code Along 2

ft_pct_2011 <-
  staff_long %>% 
  filter(faculty_type == "full_time_tenure_track", year == "2011") %>% 
  pull(value)

p2 +
  annotate(geom = "text",
           x = 1998,
           y = 3,
           size = 3,
           label = paste0("Full-time tenure track decreased to ", scales::percent(ft_pct_2011/100), " in 2011.")) -> p3

# Code Along 3

library(showtext)

font_add_google(name = "Lobster", family = "lobster")

showtext_auto()

p3 +
  theme(text = element_text(family = "lobster"))

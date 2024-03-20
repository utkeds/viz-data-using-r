# Load packages -----------------------------------------------------------

library(dsbox)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Load data ---------------------------------------------------------------

staff <- dsbox::instructors

# Check out data ----------------------------------------------------------

head(staff)

# Wrangle data ------------------------------------------------------------

staff_long <- staff %>%
  pivot_longer(cols = -year, names_to = "faculty_type") %>%
  mutate(date = as.Date(paste0(year, "-01-01")))

# Visualize data ----------------------------------------------------------

staff_long %>%
  ggplot(aes(x = year, y = value, color = faculty_type)) +
  geom_line() +
  theme_minimal() +
  labs(title = "Instructional staff employment trends",
       caption = "American Association of University Professors (AAUP)")

# Edit the title, axis labels, and legend label

staff_long %>%
  ggplot(aes(x = year, y = value, color = faculty_type)) +
  geom_line(size = 1) +
  theme_minimal() +
  labs(title = "Instructional staff employment trends",
       subtitle = "Proportion of part time faculty increasing over time",
       caption = "American Association of University Professors (AAUP)",
       y = "Proportion") +
  theme(
    plot.title = element_text(face = "bold", size = 16),
    plot.caption = element_text(size = 6),
    axis.title.x = element_blank(),
    legend.title = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = "grey90", linewidth = 0.2),
    legend.justification = c(0, 1),
    legend.position = c(0, 1),
    legend.background = element_rect(
      fill = "white", 
      linewidth = 4, 
      colour = "white"
    )
  ) +
  scale_y_continuous(name = "Proportion", limits = c(0, 100)) -> p

# Edit colors

p +
  scale_color_manual(
    values = c(
      "full_time_non_tenure_track" = "skyblue",
      "full_time_tenure_track" = "peachpuff1",
      "full_time_tenured" = "palegreen1",
      "grad_student" = "sandybrown",
      "part_time" = "maroon"
    )
  )

p +
  scale_color_manual(
    values = c(
      "full_time_non_tenure_track" = "skyblue",
      "full_time_tenure_track" = "peachpuff1",
      "full_time_tenured" = "palegreen1",
      "grad_student" = "sandybrown",
      "part_time" = "maroon"
    )
  )

library(wesanderson)

p + scale_color_manual(values = wes_palette("Zissou1"))
    
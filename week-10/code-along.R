library(tidyverse)
library(palmerpenguins)
library(gghighlight)
library(patchwork)

## Compound Figures with `patchwork`

p1 <- ggplot(mtcars) + 
  geom_point(aes(mpg, disp)) + 
  ggtitle('Plot 1')

p2 <- ggplot(mtcars) + 
  geom_boxplot(aes(gear, disp, group = gear)) + 
  ggtitle('Plot 2')

p3 <- ggplot(mtcars) + 
  geom_point(aes(hp, wt, colour = mpg)) + 
  ggtitle('Plot 3')

p4 <- ggplot(mtcars) + 
  geom_bar(aes(gear)) + 
  facet_wrap(~cyl) + 
  ggtitle('Plot 4')

p1 + p2 + p3 + p4 + 
  plot_layout(widths = c(2, 1),
              nrow = 2,
              guides = 'collect') +
   plot_annotation(
     title = 'The surprising truth about mtcars')

## faceted figures with palmerpenguins

ggplot(data = penguins, 
       aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), 
                 alpha = 0.5, 
                 position = "identity") + 
  scale_fill_manual(values = 
          c("darkorange","purple","cyan4")) +
  labs(x = "Flipper length (mm)",
       y = "Frequency",
       title = "Distribution of flipper lengths")+
  theme_minimal()+
  facet_wrap(~species, ncol = 3, scales="free_y")+
  theme(legend.position = "none")

# facet_grid - for multiple variables (cross-tabulation)

# annotations with mtcars

p + annotate("text", x = 3, y = 30, 
             label = "These cars are fuel-efficient",
             family = "Palatino") + # more here: http://www.cookbook-r.com/Graphs/Fonts/
  annotate("rect", xmin = 1.25, xmax = 2.5, ymin = 25, ymax = 35,
  alpha = .2, fill = "yellow") +
  theme_minimal()

# gghighlight

d <- purrr::map_dfr(
  letters,
  ~ data.frame(
    idx = 1:400,
    value = cumsum(runif(400, -1, 1)),
    type = .,
    flag = sample(c(TRUE, FALSE), size = 400, replace = TRUE),
    stringsAsFactors = FALSE
  )
)

d <- as_tibble(d)

ggplot(d) +
  geom_line(aes(x = idx, y = value, colour = type)) # ahh!

d_filtered <- d %>%
  group_by(type) %>% 
  filter(max(value) > 20) %>% # one option
  ungroup()

ggplot(d_filtered) +
  geom_line(aes(idx, value, colour = type))

ggplot(d) +
  geom_line(aes(x = idx, y = value, colour = type)) +
  gghighlight(type %in% c("j", "m", "r"))

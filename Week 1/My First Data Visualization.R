# NOTe: skip this step if you already have these installed
# install.packages("tidyverse")
# install.packages("here")

# Load Packages ----
library(tidyverse)
library(here)



# Load Data ----
# Data downloaded from https://drive.google.com/uc?export=download&id=10iLUo9Yo35valjPmhzlvVlvjx1cd1YQF

gapminder_data <- read_csv(here("Week 1", "gapminder.csv"))


## Prepare Data ----

gapminder_cleaned <- gapminder_data %>% 
  # select only the year 2007
  filter(year == "2007") %>%
  # change columns
  mutate(
    # Place any country in Oceania in Asia
    continent = ifelse(continent == "Oceania", "Asia", as.character(continent)),
    # Create the factor order for the continents
    continent = factor(continent, levels=c("Asia", "Americas", "Europe", "Africa"))
  ) 



## Build a Visualization ----

# Note: Visualization based on example from https://ggplot2tutor.com/tutorials/gapminder

ggplot(data = gapminder_cleaned, 
       aes(x = gdpPercap, 
           y = lifeExp)) +
  annotate("text", x = 4000, y = 45, hjust = 0.5,
           size = 85, color = "grey80",
           label = "2007", alpha = .3)+
  geom_point(aes(size = pop, fill = continent),
             shape = 21,
             color = "black")+
  guides(size = "none",
         fill = guide_legend(override.aes = list(size = 5)))+
  scale_fill_manual(values = c("Asia" = "#c15dcb",
                               "Americas" = "#057575",
                               "Africa" = "#ff7500" ,
                               "Europe" = "#1E90FF"),
                    name=NULL) +
  scale_x_log10(breaks = c(0500, 1000, 2000, 4000,
                           8000, 16000, 32000, 64000))+
  scale_y_continuous(breaks = seq(0, 120, by = 10))+
  scale_size_continuous(range = c(1, 30))+
  annotate("curve", x = 2500, xend = 2014, y = 39, yend = 46.9, 
           color = "#606F7B", linetype = 2, size = .2,  curvature = 0.5)+
  annotate("text", x = 2300, y = 30, hjust = 0,
           size = 3.5,
           label = paste0("Nigeria had a life expectancy of\n",
                          "46.9 years and an annual income of",
                          "\n$2014 per year per person in 2007"))+
  labs(
    x = "Income",
    y = "Life expectancy",
    title = "Life Expectancy and Income in 2007",
    subtitle = paste0("In the following visualization you can see the relationship between income and life expectancy among all countries in 2007.",
                      "\nAfrican countries are still lagging behind in terms of general life expectancy. The European and American countries",
                      "\nare the healthiest and richest countries in the world."),
    caption = "per person (GDP/capita, PPP$ inflation-adjusted)"
  ) +
  theme(
    panel.background =element_rect(fill="white", color="white"), 
    plot.margin = unit(rep(1, 4), "cm"),
    plot.title = element_text(size=14, face="bold"),
    plot.caption = element_text(size=8, color="grey50"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(size = 0.2, 
                                    color = "#e5e5e5"),
    axis.title.y = element_text(margin = margin(r = 15), 
                                size = 11),
    axis.title.x = element_text(margin = margin(t = 15), 
                                size = 11),
    axis.line = element_line(color = "#999999", 
                             size = 0.2),
    legend.position = "top"
  ) +
  coord_cartesian(ylim = c(0, 100))


# Save plot ----
ggsave(plot=last_plot(), filename = here("Week 1", "gapminder.jpg"), height = 6, width=10)

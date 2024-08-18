#Survey Visuals from Google Form

library(googlesheets4)
library(tidyverse)
library(ggtext)

#Export as 1300x650

# Authenticate and save the token to a file
gs4_auth(
  scopes = "https://www.googleapis.com/auth/spreadsheets.readonly")

#Import six variables from the Google Form
df <- read_sheet("https://docs.google.com/spreadsheets/d/1FsM0BXtfrT-x5wGUBNW0QNA3ia-0DCzeP6nxfrK9Fzw/edit?gid=478049066#gid=478049066") |>
  select(c(9:14))


how_often_graphs <- df |>
  select(c(1:3)) |>
  pivot_longer(cols = everything(), names_to = "Question", values_to = "Response") |>
  mutate(Response = fct_relevel(Response,c("Never", "Less than once per year", "Several times per year", "Monthly", "Daily")),
         Question = fct_relevel(Question,c("How often do you currently use each of the following? [Statistical software with a point-and-click graphical user interface (e.g., SPSS, SAS)]",
                                           "How often do you currently use each of the following? [Spreadsheet software (e.g., Excel, Google Sheets)]",
                                           "How often do you currently use each of the following? [Data analysis notebooks (e.g., R Markdown, Jupyter Notebook) or programming languages (e.g., R, python)]")),
         Question = fct_recode(Question,"<b style='color:#2D912A; font-size:11pt;'>Point-and-Click Software:</b><span style='font-size:11pt;'> SPSS, SAS, etc.</span>"="How often do you currently use each of the following? [Statistical software with a point-and-click graphical user interface (e.g., SPSS, SAS)]",
                                          "<b style='color:#792E84; font-size:11pt;'>Spreadsheets:</b><span style='font-size:11pt;'> Excel, Google Sheets, etc.</span>"="How often do you currently use each of the following? [Spreadsheet software (e.g., Excel, Google Sheets)]",
                                          "<b style='color:#E06100; font-size:11pt;'>Programming Languages & Notebooks:</b><span style='font-size:11pt;'> R, Python, etc.</span>"="How often do you currently use each of the following? [Data analysis notebooks (e.g., R Markdown, Jupyter Notebook) or programming languages (e.g., R, python)]")) |>
  ggplot(aes(x = Response, fill = Question)) +
  geom_bar(aes(fill=Question),position = "dodge", stat = "count", alpha=.7) +
  geom_text(aes(label = after_stat(count)), 
            stat = "count", 
            position = position_dodge(width = 0.9), 
            vjust = 0,
            hjust = -1) +
  geom_hline(yintercept = 0, color = "black", linewidth = 1.5) +
  labs(title="How often do you use...?",
       x = NULL,
       y = NULL) +
  theme_minimal() +
  scale_fill_manual(values = c("#2D912A","#792E84","#E06100")) +
  theme(text = element_text(family = "Roboto Condensed"),
        legend.position = "none",
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_line(color="#bfbfbf"),
        plot.title = element_text(family = "DIN Condensed", size=22, hjust = 0, margin=margin(b=20)),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 12),
        strip.text = element_markdown(),
        panel.spacing = unit(3,"lines"))+
  coord_flip()+
  facet_wrap(~Question)

level_of_confidence_graphs <- df |>
  select(c(4:6)) |>
  pivot_longer(cols = everything(), names_to = "Question", values_to = "Response") |>
  mutate(Response = fct_relevel(Response,c("Strongly disagree", "Disagree", "Somewhat disagree", "Neither agree nor disagree", "Somewhat agree", "Agree","Strongly agree")),
         Question = fct_relevel(Question,c("Please rate your level of agreement with the following statements. [While working on a data analysis project, if I got stuck, I can find ways of overcoming the problem.]",
                                           "Please rate your level of agreement with the following statements. [I know how to search for answers to my technical questions online. (2)]",
                                           "Please rate your level of agreement with the following statements. [I am confident in my ability to make use of statistical software to work with data.]")),
         Question = fct_recode(Question,"<span style='font-size:11pt;'>...confident in </span><b style='color:#28AF7F; font-size:11pt;'>Overcoming Problems</b>"="Please rate your level of agreement with the following statements. [While working on a data analysis project, if I got stuck, I can find ways of overcoming the problem.]",
                               "<span style='font-size:11pt;'>...confident in </span><b style='color:#32648E; font-size:11pt;'>Searching for Technical Answers Online</b>"="Please rate your level of agreement with the following statements. [I know how to search for answers to my technical questions online. (2)]",
                               "<span style='font-size:11pt;'>...confident in </span><b style='color:#481568; font-size:11pt;'>Making Use of Statistical Software</b>"="Please rate your level of agreement with the following statements. [I am confident in my ability to make use of statistical software to work with data.]")) |>
  ggplot(aes(x = Response, fill = Question)) +
  geom_bar(aes(fill=Question),position = "dodge", stat = "count", alpha=.7) +
  geom_text(aes(label = after_stat(count)), 
            stat = "count", 
            position = position_dodge(width = 0.9), 
            vjust = 0,
            hjust = -1) +
  geom_hline(yintercept = 0, color = "black", linewidth = 1.5) +
  labs(title="To what degree are you...?",
       x = NULL,
       y = NULL) +
  theme_minimal() +
  scale_fill_manual(values = c("#28AF7F","#32648E","#481568")) +
  theme(text = element_text(family = "Roboto Condensed"),
        legend.position = "none",
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_line(color="#bfbfbf"),
        plot.title = element_text(family = "DIN Condensed", size=22, hjust = 0, margin=margin(b=20)),
        axis.text.y = element_text(size = 12),
        axis.text.x = element_text(size = 12),
        strip.text = element_markdown(),
        panel.spacing = unit(3,"lines"))+
  coord_flip()+
  facet_wrap(~Question)

#Comment out block

tidykids <- tidykids |>
  mutate(region = case_when(
    state %in% c("Maine", "New Hampshire", "Vermont", "Massachusetts", "Rhode Island", 
                 "Connecticut", "New York", "New Jersey", "Pennsylvania") ~ "Northeast",
    state %in% c("Ohio", "Indiana", "Illinois", "Michigan", "Wisconsin", "Minnesota",
                 "Iowa", "Missouri", "North Dakota", "South Dakota", "Nebraska", "Kansas") ~ "Midwest",
    state %in% c("Delaware", "Maryland", "Virginia", "West Virginia", "North Carolina", 
                 "South Carolina", "Georgia", "Florida", "Kentucky", "Tennessee", 
                 "Alabama", "Mississippi", "Arkansas", "Louisiana", "Oklahoma",
                 "Texas", "District of Columbia") ~ "South",
    state %in% c("Montana", "Idaho", "Wyoming", "Colorado", "New Mexico", "Arizona", 
                 "Utah", "Nevada", "California", "Oregon", "Washington", "Hawaii",
                 "Alaska") ~ "West"
  ))

# Show how to run partial code, store to temp, view, etc.

tidykids |> 
  filter(year >= 2006, region == "South") |> 
  ggplot(aes(x=state, y=inf_adj_perchild)) +
  geom_col(fill="blue")

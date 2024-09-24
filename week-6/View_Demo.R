library(tidykids)
tidykids <- tidykids

tidykids_tnva<-tidykids |> 
  filter(state == "Tennessee" | state == "Virginia"  & variable == "PK12ed")

tidykids_tnva <- tidykids |>
  filter(state %in% c("Tennessee", "Virginia") & variable == "PK12ed")


View()

# tidykids_tnva |>
#   group_by(state) |>
#   summarize(total_amt = sum (inf_adj_perchild, na.rm=T)) |>
#   ungroup()

tidykids_tnva |> 
  ggplot(aes(x = state, y = inf_adj_perchild)) + 
  geom_col(fill = "purple") +
  scale_y_continuous(labels = scales::dollar)

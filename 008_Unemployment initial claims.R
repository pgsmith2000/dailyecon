# set start and end dates
end_date <- Sys.Date() - 1

if (wday(end_date) == 1){
  end_date <- end_date - 3
} else if (wday(end_date) == 7){
  end_date <- end_date - 2
}
start_date <- end_date - (3*(13*7))

# last 45 days of SLVPRUSD
fr_IC4WSA <- makeFREDtable("IC4WSA", start.date = start_date, end.date = end_date)

# caluculate limit for gragph
delta <- ((max(fr_IC4WSA$IC4WSA) - min(fr_IC4WSA$IC4WSA))/.8) *.1
low.delta <- min(fr_IC4WSA$IC4WSA) - (6*delta)
high.delta <- max(fr_IC4WSA$IC4WSA) + (2*delta)              


# Plot it
p8 <- ggplot(fr_IC4WSA, aes(x=date, y=IC4WSA))
p8 <- p8 + geom_line(size=2, color="peru") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(low.delta,high.delta)) +
  stat_smooth(method = lm) +
  labs(title="8. 4-Wk Avg Initial claims", x="", y="",
       caption = "US ETA.") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))

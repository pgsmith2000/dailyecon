# set start and end dates
end_date <- Sys.Date() - 1

if (wday(end_date) == 1){
  end_date <- end_date - 3
} else if (wday(end_date) == 7){
  end_date <- end_date - 2
}
start_date <- ymd("19800101")

# last 45 days of GDP
fr_GDP <- makeFREDtable("GDP", start.date = start_date, end.date = end_date)

# caluculate limit for gragph
delta <- ((max(fr_GDP$GDP) - min(fr_GDP$GDP))/.8) *.1
low.delta <- min(fr_GDP$GDP) - delta
high.delta <- max(fr_GDP$GDP) + delta                 


# Plot it
p10 <- ggplot(fr_GDP, aes(x=date, y=GDP))
p10 <- p10 + geom_line(size=2, color="peru") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(0,high.delta)) +
  stat_smooth(method = lm) +
  labs(title="10. Gross Domestic Product", x="", y="",
       caption = "FRB St. Louis") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))



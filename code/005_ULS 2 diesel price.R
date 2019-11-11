# set start and end dates
end_date <- Sys.Date() - 1

if (wday(end_date) == 1){
  end_date <- end_date - 3
} else if (wday(end_date) == 7){
  end_date <- end_date - 2
}
start_date <- end_date - (45)

# last 45 days of DDFUELLA
fr_DDFUELLA <- makeFREDtable("DDFUELLA", start.date = start_date, end.date = end_date)

# Plot it
p5 <- ggplot(fr_DDFUELLA, aes(x=date, y=DDFUELLA))
p5 <- p5 + geom_line(size=2, color="darkgreen") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(1.85,2.20)) +
  stat_smooth(method = lm) +
  labs(title="5. ULS #2 Diesel Price", x="", y="Dollars per Gallon",
       caption = "ULS #2 Diesel Price, U.S. EIA") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))


# set start and end dates
end_date <- now() - 1
if(wday(now() - 1) > 6 || wday(now() - 1) == 1){
  end_date <- as_date(now() - days(wday(now() - 1)-6))
}
start_date <- as_date((now() - 1) - days(45))

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

# yesterday <- as_date(now() - days(1))
today <- as_date(now())
yesterday <- as_date(now() - days(1))
end_date <- yesterday
if(wday(yesterday) > 6){
  end_date <- as_date(now() - days(wday(yesterday)-6))
}
start_date <- as_date(yesterday-days(45))

# last 30 days for DDFUELLA
fr_DDFUELLA <- fredr(series_id = "DDFUELLA",
                 start_date, end_date)
fr_DDFUELLA$series_id <- NULL
names(fr_DDFUELLA)[2] <- "DDFUELLA"

# Plot it
p5 <- ggplot(fr_DDFUELLA, aes(x=date, y=DDFUELLA))
p5 <- p5 + geom_line(size=2, color="darkgreen") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(1.85,2.20)) +
  stat_smooth(method = lm) +
  labs(title="5. ULS #2 Diesel Price", x="", y="Dollars per Gallon") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))
  


# set FRED key
user_api_key<-read.csv("../../fred_api_key.csv", 
                       stringsAsFactors=TRUE, as.is=TRUE)
fredr_set_key(user_api_key$fredAPIkey)

# yesterday <- as_date(now() - days(1))
today <- as_date(now())
yesterday <- as_date(now() - days(1))
end_date <- yesterday
if(wday(yesterday) > 6){
  end_date <- as_date(now() - days(wday(yesterday)-6))
}
start_date <- as_date(yesterday-days(45))

# last 30 days for DGASUSGULF
fr_DGASUSGULF <- fredr(series_id = "DGASUSGULF",
                 start_date, end_date)
fr_DGASUSGULF$series_id <- NULL
names(fr_DGASUSGULF)[2] <- "DGASUSGULF"

# Plot it
p3 <- ggplot(fr_DGASUSGULF, aes(x=date, y=DGASUSGULF))
p3 <- p3 + geom_line(size=2, color="darkgreen") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(4)) + xlab("") +
  scale_y_continuous(limit=c(1.5,1.8)) +
  stat_smooth(method = lm) +
  labs(title="3. Regular Gasoline Price", x="", y="Dollars per Gallon") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))
  


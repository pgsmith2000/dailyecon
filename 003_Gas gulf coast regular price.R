# set FRED key
user_api_key<-read.csv("../../fred_api_key.csv", 
                       stringsAsFactors=TRUE, as.is=TRUE)
fredr_set_key(user_api_key$fredAPIkey)

# set start and end dates
end_date <- now() - 1
if(wday(now() - 1) > 6 || wday(now() - 1) == 1){
  end_date <- as_date(now() - days(wday(now() - 1)-6))
}
start_date <- as_date((now() - 1) - days(45))

# last 45 days of DGASUSGULF
fr_DGASUSGULF <- makeFREDtable("DGASUSGULF", start.date = start_date, end.date = end_date)

# Plot it
p3 <- ggplot(fr_DGASUSGULF, aes(x=date, y=DGASUSGULF))
p3 <- p3 + geom_line(size=2, color="darkgreen") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) + xlab("") +
  scale_y_continuous(limit=c(1.5,1.8)) +
  stat_smooth(method = lm) +
  labs(title="3. Regular Gasoline Price", x="", y="Dollars per Gallon",
       caption = "Regular Gasoline Price, U.S. EIA") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))


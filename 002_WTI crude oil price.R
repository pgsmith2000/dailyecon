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

# last 45 days of DCOILWTICO
fr_DCOILWTICO <- makeFREDtable("DCOILWTICO", start.date = start_date, end.date = end_date)

# Plot it
p2 <- ggplot(fr_DCOILWTICO, aes(x=date, y=DCOILWTICO))
p2 <- p2 + geom_line(size=2, color="darkgreen") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limits = c(0,80)) +
  stat_smooth(method = lm) +
  labs(title="2. WTI Crude Oil Price", x="", y="Dollars per Barrel", 
       caption = "WTI Crude Oil Price, U.S. EIA") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))

  


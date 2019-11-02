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

# last 6 month data for DJIA, SP500, and NASDAQCOM
fr_DCOILWTICO <- fredr(series_id = "DCOILWTICO",
                 start_date, end_date)
fr_DCOILWTICO$series_id <- NULL
names(fr_DCOILWTICO)[2] <- "DCOILWTICO"

# Plot it
p2 <- ggplot(fr_DCOILWTICO, aes(x=date, y=DCOILWTICO))
p2 <- p2 + geom_line(size=2, color="darkgreen") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limits = c(0,80)) +
  stat_smooth(method = lm) +
  labs(title="2. WTI Crude Oil Price", x="", y="Dollars per Barrel") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))

  


# set start and end dates
end_date <- Sys.Date() - 1

if (wday(end_date) == 1){
  end_date <- end_date - 3
} else if (wday(end_date) == 7){
  end_date <- end_date - 2
}
start_date <- end_date - (45)


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

  


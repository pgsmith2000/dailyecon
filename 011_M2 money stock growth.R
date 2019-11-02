# set start and end dates
end_date <- now() - 1
if(wday(now() - 1) > 6 || wday(now() - 1) == 1){
  end_date <- as_date(now() - days(wday(now() - 1)-6))
}
start_date <- ymd("19800101")

# last 45 days of M2
fr_M2 <- makeFREDtable("M2", start.date = start_date, end.date = end_date)

# caluculate limit for gragph
delta <- ((max(fr_M2$M2) - min(fr_M2$M2))/.8) *.1
low.delta <- min(fr_M2$M2) - delta
high.delta <- max(fr_M2$M2) + delta                 


# Plot it
p11 <- ggplot(fr_M2, aes(x=date, y=M2))
p11 <- p11 + geom_line(size=2, color="peru") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(0,high.delta)) +
  stat_smooth(method = lm) +
  labs(title="11. M2 Money Stock", x="", y="",
       caption = "Billions of Dollars, Seasonally Adjusted; FRB St. Louis") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))


# set start and end dates
end_date <- now() - 1
if(wday(now() - 1) > 6 || wday(now() - 1) == 1){
  end_date <- as_date(now() - days(wday(now() - 1)-6))
}
start_date <- as_date((now() - 1) - days(2*(14*7)))

# last 45 days of T5YIE
fr_T5YIE <- makeFREDtable("T5YIE", start.date = start_date, end.date = end_date)

# caluculate limit for gragph
delta <- ((max(fr_T5YIE$T5YIE) - min(fr_T5YIE$T5YIE))/.8) *.1
low.delta <- min(fr_T5YIE$T5YIE) - delta
high.delta <- max(fr_T5YIE$T5YIE) + delta                 


# Plot it
p9 <- ggplot(fr_T5YIE, aes(x=date, y=T5YIE))
p9 <- p9 + geom_line(size=2, color="peru") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(0,high.delta)) +
  stat_smooth(method = lm) +
  labs(title="9. 5 Year Breakeven Inflation Rate", x="", y="") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))

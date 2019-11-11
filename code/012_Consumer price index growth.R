# set start and end dates
end_date <- Sys.Date() - 1

if (wday(end_date) == 1){
  end_date <- end_date - 3
} else if (wday(end_date) == 7){
  end_date <- end_date - 2
}
start_date <- ymd("19800101")

# last 45 days of CPALTT01USM661S
fr_CPALTT01USM661S <- makeFREDtable("CPALTT01USM661S", start.date = start_date, end.date = end_date)

# caluculate limit for gragph
delta <- ((max(fr_CPALTT01USM661S$CPALTT01USM661S) - min(fr_CPALTT01USM661S$CPALTT01USM661S))/.8) *.1
low.delta <- min(fr_CPALTT01USM661S$CPALTT01USM661S) - delta
high.delta <- max(fr_CPALTT01USM661S$CPALTT01USM661S) + delta                 


# Plot it
p12 <- ggplot(fr_CPALTT01USM661S, aes(x=date, y=CPALTT01USM661S))
p12 <- p12 + geom_line(size=2, color="peru") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(0,high.delta)) +
  stat_smooth(method = lm) +
  labs(title="12. Consumer Price Index Growth", x="", y="",
       caption = "FRB St. Louis") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))

ggsave("../output/p12.png", p12)


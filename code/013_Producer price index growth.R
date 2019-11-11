# set start and end dates
end_date <- Sys.Date() - 1

if (wday(end_date) == 1){
  end_date <- end_date - 3
} else if (wday(end_date) == 7){
  end_date <- end_date - 2
}
start_date <- ymd("19800101")

# last 45 days of PPIACO
fr_PPIACO <- makeFREDtable("PPIACO", start.date = start_date, end.date = end_date)

# caluculate limit for gragph
delta <- ((max(fr_PPIACO$PPIACO) - min(fr_PPIACO$PPIACO))/.8) *.1
low.delta <- min(fr_PPIACO$PPIACO) - delta
high.delta <- max(fr_PPIACO$PPIACO) + delta                 


# Plot it
p13 <- ggplot(fr_PPIACO, aes(x=date, y=PPIACO))
p13 <- p13 + geom_line(size=2, color="peru") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(0,high.delta)) +
  stat_smooth(method = lm) +
  labs(title="13. Producer Price Index", x="", y="",
       caption = "FRB St. Louis") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))

ggsave("../output/p13.png", p13)


# set start and end dates
end_date <- Sys.Date() - 1

if (wday(end_date) == 1){
  end_date <- end_date - 3
} else if (wday(end_date) == 7){
  end_date <- end_date - 2
}
start_date <- end_date - (2*(13*7))

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
  labs(title="9. 5 Year Breakeven Inflation Rate", x="", y="",
       caption = "FRB St. Louis") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))

ggsave("../output/p9.png", p9)

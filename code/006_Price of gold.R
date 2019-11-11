# set start and end dates
end_date <- Sys.Date() - 1

if (wday(end_date) == 1){
  end_date <- end_date - 3
} else if (wday(end_date) == 7){
  end_date <- end_date - 2
}
start_date <- end_date - (45)

# last 45 days of GOLDAMGBD228NLBM
fr_GOLDAMGBD228NLBM <- makeFREDtable("GOLDAMGBD228NLBM", start.date = start_date, end.date = end_date)

# caluculate limit for gragph
delta <- ((max(fr_GOLDAMGBD228NLBM$GOLDAMGBD228NLBM) - min(fr_GOLDAMGBD228NLBM$GOLDAMGBD228NLBM))/.8) *.1
low.delta <- min(fr_GOLDAMGBD228NLBM$GOLDAMGBD228NLBM) - (3*delta)
high.delta <- max(fr_GOLDAMGBD228NLBM$GOLDAMGBD228NLBM) + delta                 


# Plot it
p6 <- ggplot(fr_GOLDAMGBD228NLBM, aes(x=date, y=GOLDAMGBD228NLBM))
p6 <- p6 + geom_line(size=2, color="darkgreen") + theme_minimal() +
  scale_x_date(breaks = pretty_breaks(6)) +
  scale_y_continuous(limit=c(low.delta,high.delta)) +
  stat_smooth(method = lm) +
  labs(title="6. Price of Gold", x="", y="$ per Troy Ounce",
       caption = "Price of Gold, ICE Benchmark Admin. Ltd.") + 
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))

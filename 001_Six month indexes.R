# set start and end dates
end_date <- now() - 1
if(wday(now() - 1) > 6 || wday(now() - 1) == 1){
  end_date <- as_date(now() - days(wday(now() - 1)-6))
}
start_date <- as_date((now() - 1) - days(26*7) - days(1))
end_date2 <- start_date 
start_date2 <- start_date - days(26*7)

end_date - start_date
end_date2 - start_date2

# last 6 month data for DJIA, SP500, and NASDAQCOM
fr_DJIA <- fredr(series_id = "DJIA",
                 start_date, end_date)
fr_SP500 <- fredr(series_id = "SP500",
                  start_date, end_date)
fr_NASDAQCOM <- fredr(series_id = "NASDAQCOM",
                      start_date, end_date)

date <- seq(as_date(start_date), as_date(end_date), by="days")
fr_dates <- as.data.frame(date)
frIndex <- as.data.frame(bind_rows(fr_dates,fr_DJIA, fr_SP500, fr_NASDAQCOM))
frIndex$series_id <- as.factor(frIndex$series_id)
dfIndexLast6 <- spread(frIndex, series_id, value)
dfIndexLast6$`<NA>` <- NULL
dfIndexLast6 <- fill(dfIndexLast6, 2:4, .direction=c("downup"))

# last prev 6 month data for DJIA, SP500, and NASDAQCOM
fr_DJIA <- fredr(series_id = "DJIA",
                 start_date2, end_date2)
fr_SP500 <- fredr(series_id = "SP500",
                  start_date2, end_date2)
fr_NASDAQCOM <- fredr(series_id = "NASDAQCOM",
                      start_date2, end_date2)

date <- seq(as_date(start_date2), as_date(end_date2), by="days")
fr_dates <- as.data.frame(date)
frIndex <- as.data.frame(bind_rows(fr_dates,fr_DJIA, fr_SP500, fr_NASDAQCOM))
frIndex$series_id <- as.factor(frIndex$series_id)
dfIndexPrev6 <- spread(frIndex, series_id, value)
dfIndexPrev6$`<NA>` <- NULL
dfIndexPrev6 <- fill(dfIndexPrev6, 2:4, .direction=c("downup"))

# Create the major index change table
dfIndexChange <- dfIndexLast6
dfIndexChange$DJIA <- ((dfIndexLast6$DJIA - dfIndexPrev6$DJIA)/dfIndexPrev6$DJIA)
dfIndexChange$SP500 <- ((dfIndexLast6$SP500 - dfIndexPrev6$SP500)/dfIndexPrev6$SP500)
dfIndexChange$NASDAQCOM <- 
  ((dfIndexLast6$NASDAQCOM - dfIndexPrev6$NASDAQCOM)/dfIndexPrev6$NASDAQCOM)

# Make it long for ggplot
dfIndexChange_long <- gather(dfIndexChange, Symbol, Change,-date)

# Plot it
p1 <- ggplot(dfIndexChange_long, aes(x=date, y=Change, group=Symbol))
p1 <- p1 + geom_line(aes(color=Symbol), size=2) +
  scale_y_continuous(labels=scales::percent) +
  scale_color_manual(values=c('navyblue','darkgreen', 'peru')) +
  scale_x_date(breaks = pretty_breaks(6), date_labels = "%d %b") +
  labs(title = "1. Six-Month Change in Major Stock Indexes", 
       x="", 
       color="", 
       subtitle = "", 
       caption = "\uA9 S&P Dow Jones Indices LLC \uA9 NASDAQ OMX Group") +
  theme_minimal() +
  theme(legend.position = 'bottom') +
  theme(axis.text.x = element_text(angle = 45))





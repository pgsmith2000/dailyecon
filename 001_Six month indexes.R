# load libraries
library(fredr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(scales)


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
start_date <- as_date(now()-days(26*7) - days())
start_date2 <- as_date(start_date - days(26*7))
end_date2 <- as_date(end_date-days(26*7))


# last 6 month
fr_DJIA <- fredr(series_id = "DJIA",
                 start_date, end_date)
fr_DJIA <- fill(fr_DJIA, value, .direction=c("downup"))

fr_SP500 <- fredr(series_id = "SP500",
                  start_date, end_date)
fr_SP500 <- fill(fr_SP500, value, .direction=c("downup"))

fr_NASDAQCOM <- fredr(series_id = "NASDAQCOM",
                      start_date, end_date)
fr_NASDAQCOM <- fill(fr_NASDAQCOM, value, .direction=c("downup"))

frIndex <- as.data.frame(bind_rows(fr_DJIA, fr_SP500, fr_NASDAQCOM))
frIndex$series_id <- as.factor(frIndex$series_id)
dfIndexLast6 <- spread(frIndex, series_id, value)

# prev 6 months
fr_DJIA <- fredr(series_id = "DJIA",
                 start_date2, end_date2)
fr_DJIA <- fill(fr_DJIA, value, .direction=c("downup"))

fr_SP500 <- fredr(series_id = "SP500",
                  start_date2, end_date2)
fr_SP500 <- fill(fr_SP500, value, .direction=c("downup"))

fr_NASDAQCOM <- fredr(series_id = "NASDAQCOM",
                      start_date2, end_date2)
fr_NASDAQCOM <- fill(fr_NASDAQCOM, value, .direction=c("downup"))

frIndex <- as.data.frame(bind_rows(fr_DJIA, fr_SP500, fr_NASDAQCOM))
frIndex$series_id <- as.factor(frIndex$series_id)
dfIndexPrev6 <- spread(frIndex, series_id, value)

dfIndexChange <- dfIndexLast6
dfIndexChange$DJIA <- ((dfIndexPrev6$DJIA - dfIndexLast6$DJIA)/dfIndexPrev6$DJIA)
dfIndexChange$SP500 <- ((dfIndexPrev6$SP500 - dfIndexLast6$SP500)/dfIndexPrev6$SP500)
dfIndexChange$NASDAQCOM <- 
  ((dfIndexPrev6$NASDAQCOM - dfIndexLast6$NASDAQCOM)/dfIndexPrev6$NASDAQCOM)

dfIndexChange_long <- gather(dfIndexChange, Symbol, Change,-date)


a <- ggplot(dfIndexChange_long, aes(x=date, y=Change, group=Symbol))
a + geom_line(aes(color=Symbol), size=2) + 
  scale_y_continuous(labels=scales::percent) +
  scale_color_manual(values=c('navyblue','forestgreen', 'peru')) +
  scale_x_date(breaks = pretty_breaks(6)) + xlab("") +
  labs(title="1. Six-Month Change in Major Stock Indexes", x="", y="", color="") +
  theme_minimal() + theme(legend.position = 'bottom')




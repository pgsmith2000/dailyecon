Daily information summary of economic indicators available from FRED,
FRB St. Louis
================
Paul G. Smith
First created on Oct 31, 2019. Updated on Nov 11, 2019

  - [Daily information summary of economic indicators available from
    FRED, FRB
    St. Louis](#daily-information-summary-of-economic-indicators-available-from-fred-frb-st.-louis)
      - [Monday Morning Update: November 11,
        2019](#monday-morning-update-november-11-2019)
      - [1. Six-Month Change in Major Stock
        Indexes](#six-month-change-in-major-stock-indexes)
      - [2. WTI Crude Oil Price](#wti-crude-oil-price)
      - [3. Regular Gasoline Price](#regular-gasoline-price)
      - [4. Gasoline % of Oil Price](#gasoline-of-oil-price)
      - [5. ULS \#2 Diesel Price](#uls-2-diesel-price)
      - [6. Price of Gold](#price-of-gold)
      - [7. Price of Silver](#price-of-silver)
      - [8. 4-Wk Moving Avg Unemployment Initial
        Claims](#wk-moving-avg-unemployment-initial-claims)
      - [9. Breakeven Inflation, 5-Year](#breakeven-inflation-5-year)
      - [10. GDP Growth Since 1980](#gdp-growth-since-1980)
      - [11. M2 Money Stock Growth Since
        1980](#m2-money-stock-growth-since-1980)
      - [12. Consumer Price Index Growth Since
        1980](#consumer-price-index-growth-since-1980)
      - [13. Producer Price Index Growth Since
        1980](#producer-price-index-growth-since-1980)
      - [Finally, Print the Plots for Monday Morning Update: November
        11,
        2019](#finally-print-the-plots-for-monday-morning-update-november-11-2019)

## Daily information summary of economic indicators available from FRED, FRB St. Louis

Back to **[Index](index.md)**

``` r
source("../code/Dependencies.R", echo = TRUE)
```

    ## 
    ## > library(fredr)
    ## 
    ## > library(tidyverse)

    ## -- Attaching packages ------------------------------ tidyverse 1.2.1 --

    ## v ggplot2 3.2.1     v purrr   0.3.3
    ## v tibble  2.1.3     v dplyr   0.8.3
    ## v tidyr   1.0.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.4.0

    ## -- Conflicts --------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    ## 
    ## > library(lubridate)

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

    ## 
    ## > library(scales)

    ## 
    ## Attaching package: 'scales'

    ## The following object is masked from 'package:purrr':
    ## 
    ##     discard

    ## The following object is masked from 'package:readr':
    ## 
    ##     col_factor

    ## 
    ## > library(gridExtra)

    ## 
    ## Attaching package: 'gridExtra'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     combine

    ## 
    ## > setwd("../code/")
    ## 
    ## > user_api_key <- read.csv("../../../fred_api_key.csv", 
    ## +     stringsAsFactors = TRUE, as.is = TRUE)
    ## 
    ## > fredr_set_key(user_api_key$fredAPIkey)

``` r
source("../code/Functions.R", echo = TRUE)
```

    ## 
    ## > makeFREDtable <- function(symbol, start.date, end.date) {
    ## +     df <- fredr(series_id = symbol, start.date, end.date)
    ## +     df$series_id <- NULL
    ## +   .... [TRUNCATED]

### Monday Morning Update: November 11, 2019

### 1\. Six-Month Change in Major Stock Indexes

``` r
source("../code/001_Six month indexes.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- end_date - (26 * 7)
    ## 
    ## > end_date2 <- start_date
    ## 
    ## > start_date2 <- start_date - (26 * 7)
    ## 
    ## > fr_DJIA <- fredr(series_id = "DJIA", start_date, end_date)
    ## 
    ## > fr_SP500 <- fredr(series_id = "SP500", start_date, 
    ## +     end_date)
    ## 
    ## > fr_NASDAQCOM <- fredr(series_id = "NASDAQCOM", start_date, 
    ## +     end_date)
    ## 
    ## > date <- seq(start_date, end_date, by = "days")
    ## 
    ## > fr_dates <- as.data.frame(date)
    ## 
    ## > frIndex <- as.data.frame(bind_rows(fr_dates, fr_DJIA, 
    ## +     fr_SP500, fr_NASDAQCOM))
    ## 
    ## > frIndex$series_id <- as.factor(frIndex$series_id)
    ## 
    ## > dfIndexLast6 <- spread(frIndex, series_id, value)
    ## 
    ## > dfIndexLast6$`<NA>` <- NULL
    ## 
    ## > dfIndexLast6 <- fill(dfIndexLast6, 2:4, .direction = c("downup"))
    ## 
    ## > fr_DJIA <- fredr(series_id = "DJIA", start_date2, 
    ## +     end_date2)
    ## 
    ## > fr_SP500 <- fredr(series_id = "SP500", start_date2, 
    ## +     end_date2)
    ## 
    ## > fr_NASDAQCOM <- fredr(series_id = "NASDAQCOM", start_date2, 
    ## +     end_date2)
    ## 
    ## > date <- seq(start_date2, end_date2, by = "days")
    ## 
    ## > fr_dates <- as.data.frame(date)
    ## 
    ## > frIndex <- as.data.frame(bind_rows(fr_dates, fr_DJIA, 
    ## +     fr_SP500, fr_NASDAQCOM))
    ## 
    ## > frIndex$series_id <- as.factor(frIndex$series_id)
    ## 
    ## > dfIndexPrev6 <- spread(frIndex, series_id, value)
    ## 
    ## > dfIndexPrev6$`<NA>` <- NULL
    ## 
    ## > dfIndexPrev6 <- fill(dfIndexPrev6, 2:4, .direction = c("downup"))
    ## 
    ## > dfIndexChange <- dfIndexLast6
    ## 
    ## > dfIndexChange$DJIA <- ((dfIndexLast6$DJIA - dfIndexPrev6$DJIA)/dfIndexPrev6$DJIA)
    ## 
    ## > dfIndexChange$SP500 <- ((dfIndexLast6$SP500 - dfIndexPrev6$SP500)/dfIndexPrev6$SP500)
    ## 
    ## > dfIndexChange$NASDAQCOM <- ((dfIndexLast6$NASDAQCOM - 
    ## +     dfIndexPrev6$NASDAQCOM)/dfIndexPrev6$NASDAQCOM)
    ## 
    ## > dfIndexChange_long <- gather(dfIndexChange, Symbol, 
    ## +     Change, -date)
    ## 
    ## > p1 <- ggplot(dfIndexChange_long, aes(x = date, y = Change, 
    ## +     group = Symbol))
    ## 
    ## > p1 <- p1 + geom_line(aes(color = Symbol), size = 2) + 
    ## +     scale_y_continuous(labels = scales::percent) + scale_color_manual(values = c("navyblue" .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p1.png", p1)

    ## Saving 7 x 5 in image

### 2\. WTI Crude Oil Price

``` r
source("../code/002_WTI crude oil price.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- end_date - (45)
    ## 
    ## > fr_DCOILWTICO <- makeFREDtable("DCOILWTICO", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > p2 <- ggplot(fr_DCOILWTICO, aes(x = date, y = DCOILWTICO))
    ## 
    ## > p2 <- p2 + geom_line(size = 2, color = "darkgreen") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(l .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p2.png", p2)

    ## Saving 7 x 5 in image

### 3\. Regular Gasoline Price

``` r
source("../code/003_Gas gulf coast regular price.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- end_date - (45)
    ## 
    ## > fr_DGASUSGULF <- makeFREDtable("DGASUSGULF", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > p3 <- ggplot(fr_DGASUSGULF, aes(x = date, y = DGASUSGULF))
    ## 
    ## > p3 <- p3 + geom_line(size = 2, color = "darkgreen") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     xlab("") + scale_y_c .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p3.png", p3)

    ## Saving 7 x 5 in image

### 4\. Gasoline % of Oil Price

``` r
source("../code/004_Gas percent of oil.R", echo = TRUE)
```

    ## 
    ## > fr_gaspercentoil <- fr_DGASUSGULF
    ## 
    ## > fr_gaspercentoil$DGASUSGULF <- (fr_DGASUSGULF$DGASUSGULF/fr_DCOILWTICO$DCOILWTICO) * 
    ## +     100
    ## 
    ## > names(fr_gaspercentoil)[2] <- "Percent"
    ## 
    ## > p4 <- ggplot(fr_gaspercentoil, aes(x = date, y = Percent))
    ## 
    ## > p4 <- p4 + geom_line(size = 2, color = "darkgreen") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(l .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p4.png", p4)

    ## Saving 7 x 5 in image

### 5\. ULS \#2 Diesel Price

``` r
source("../code/005_ULS 2 diesel price.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- end_date - (45)
    ## 
    ## > fr_DDFUELLA <- makeFREDtable("DDFUELLA", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > p5 <- ggplot(fr_DDFUELLA, aes(x = date, y = DDFUELLA))
    ## 
    ## > p5 <- p5 + geom_line(size = 2, color = "darkgreen") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(l .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p5.png", p5)

    ## Saving 7 x 5 in image

### 6\. Price of Gold

``` r
source("../code/006_Price of gold.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- end_date - (45)
    ## 
    ## > fr_GOLDAMGBD228NLBM <- makeFREDtable("GOLDAMGBD228NLBM", 
    ## +     start.date = start_date, end.date = end_date)
    ## 
    ## > delta <- ((max(fr_GOLDAMGBD228NLBM$GOLDAMGBD228NLBM) - 
    ## +     min(fr_GOLDAMGBD228NLBM$GOLDAMGBD228NLBM))/0.8) * 0.1
    ## 
    ## > low.delta <- min(fr_GOLDAMGBD228NLBM$GOLDAMGBD228NLBM) - 
    ## +     (3 * delta)
    ## 
    ## > high.delta <- max(fr_GOLDAMGBD228NLBM$GOLDAMGBD228NLBM) + 
    ## +     delta
    ## 
    ## > p6 <- ggplot(fr_GOLDAMGBD228NLBM, aes(x = date, y = GOLDAMGBD228NLBM))
    ## 
    ## > p6 <- p6 + geom_line(size = 2, color = "darkgreen") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(l .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p6.png", p6)

    ## Saving 7 x 5 in image

### 7\. Price of Silver

``` r
source("../code/007_Price of silver.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- end_date - (45)
    ## 
    ## > fr_SLVPRUSD <- makeFREDtable("SLVPRUSD", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > delta <- ((max(fr_SLVPRUSD$SLVPRUSD) - min(fr_SLVPRUSD$SLVPRUSD))/0.8) * 
    ## +     0.1
    ## 
    ## > low.delta <- min(fr_SLVPRUSD$SLVPRUSD) - (3 * delta)
    ## 
    ## > high.delta <- max(fr_SLVPRUSD$SLVPRUSD) + delta
    ## 
    ## > p7 <- ggplot(fr_SLVPRUSD, aes(x = date, y = SLVPRUSD))
    ## 
    ## > p7 <- p7 + geom_line(size = 2, color = "darkgreen") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(l .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p7.png", p7)

    ## Saving 7 x 5 in image

### 8\. 4-Wk Moving Avg Unemployment Initial Claims

``` r
source("../code/008_Unemployment initial claims.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- end_date - (3 * (13 * 7))
    ## 
    ## > fr_IC4WSA <- makeFREDtable("IC4WSA", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > delta <- ((max(fr_IC4WSA$IC4WSA) - min(fr_IC4WSA$IC4WSA))/0.8) * 
    ## +     0.1
    ## 
    ## > low.delta <- min(fr_IC4WSA$IC4WSA) - (6 * delta)
    ## 
    ## > high.delta <- max(fr_IC4WSA$IC4WSA) + (2 * delta)
    ## 
    ## > p8 <- ggplot(fr_IC4WSA, aes(x = date, y = IC4WSA))
    ## 
    ## > p8 <- p8 + geom_line(size = 2, color = "peru") + theme_minimal() + 
    ## +     scale_x_date(breaks = pretty_breaks(6)) + scale_y_continuous(limit = c(low .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p8.png", p8)

    ## Saving 7 x 5 in image

### 9\. Breakeven Inflation, 5-Year

``` r
source("../code/009_Breakeven inflation.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- end_date - (2 * (13 * 7))
    ## 
    ## > fr_T5YIE <- makeFREDtable("T5YIE", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > delta <- ((max(fr_T5YIE$T5YIE) - min(fr_T5YIE$T5YIE))/0.8) * 
    ## +     0.1
    ## 
    ## > low.delta <- min(fr_T5YIE$T5YIE) - delta
    ## 
    ## > high.delta <- max(fr_T5YIE$T5YIE) + delta
    ## 
    ## > p9 <- ggplot(fr_T5YIE, aes(x = date, y = T5YIE))
    ## 
    ## > p9 <- p9 + geom_line(size = 2, color = "peru") + theme_minimal() + 
    ## +     scale_x_date(breaks = pretty_breaks(6)) + scale_y_continuous(limit = c(0,  .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p9.png", p9)

    ## Saving 7 x 5 in image

### 10\. GDP Growth Since 1980

``` r
source("../code/010_GDP growth.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- ymd("19800101")
    ## 
    ## > fr_GDP <- makeFREDtable("GDP", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > delta <- ((max(fr_GDP$GDP) - min(fr_GDP$GDP))/0.8) * 
    ## +     0.1
    ## 
    ## > low.delta <- min(fr_GDP$GDP) - delta
    ## 
    ## > high.delta <- max(fr_GDP$GDP) + delta
    ## 
    ## > p10 <- ggplot(fr_GDP, aes(x = date, y = GDP))
    ## 
    ## > p10 <- p10 + geom_line(size = 2, color = "peru") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(limi .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p10.png", p10)

    ## Saving 7 x 5 in image

### 11\. M2 Money Stock Growth Since 1980

``` r
source("../code/011_M2 money stock growth.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- ymd("19800101")
    ## 
    ## > fr_M2 <- makeFREDtable("M2", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > delta <- ((max(fr_M2$M2) - min(fr_M2$M2))/0.8) * 0.1
    ## 
    ## > low.delta <- min(fr_M2$M2) - delta
    ## 
    ## > high.delta <- max(fr_M2$M2) + delta
    ## 
    ## > p11 <- ggplot(fr_M2, aes(x = date, y = M2))
    ## 
    ## > p11 <- p11 + geom_line(size = 2, color = "peru") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(limi .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p11.png", p11)

    ## Saving 7 x 5 in image

    ## Warning: Removed 1 rows containing missing values (geom_smooth).

### 12\. Consumer Price Index Growth Since 1980

``` r
source("../code/012_Consumer price index growth.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- ymd("19800101")
    ## 
    ## > fr_CPALTT01USM661S <- makeFREDtable("CPALTT01USM661S", 
    ## +     start.date = start_date, end.date = end_date)
    ## 
    ## > delta <- ((max(fr_CPALTT01USM661S$CPALTT01USM661S) - 
    ## +     min(fr_CPALTT01USM661S$CPALTT01USM661S))/0.8) * 0.1
    ## 
    ## > low.delta <- min(fr_CPALTT01USM661S$CPALTT01USM661S) - 
    ## +     delta
    ## 
    ## > high.delta <- max(fr_CPALTT01USM661S$CPALTT01USM661S) + 
    ## +     delta
    ## 
    ## > p12 <- ggplot(fr_CPALTT01USM661S, aes(x = date, y = CPALTT01USM661S))
    ## 
    ## > p12 <- p12 + geom_line(size = 2, color = "peru") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(limi .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p12.png", p12)

    ## Saving 7 x 5 in image

### 13\. Producer Price Index Growth Since 1980

``` r
source("../code/013_Producer price index growth.R", echo = TRUE)
```

    ## 
    ## > end_date <- Sys.Date() - 1
    ## 
    ## > if (wday(end_date) == 1) {
    ## +     end_date <- end_date - 3
    ## + } else if (wday(end_date) == 7) {
    ## +     end_date <- end_date - 2
    ## + }
    ## 
    ## > start_date <- ymd("19800101")
    ## 
    ## > fr_PPIACO <- makeFREDtable("PPIACO", start.date = start_date, 
    ## +     end.date = end_date)
    ## 
    ## > delta <- ((max(fr_PPIACO$PPIACO) - min(fr_PPIACO$PPIACO))/0.8) * 
    ## +     0.1
    ## 
    ## > low.delta <- min(fr_PPIACO$PPIACO) - delta
    ## 
    ## > high.delta <- max(fr_PPIACO$PPIACO) + delta
    ## 
    ## > p13 <- ggplot(fr_PPIACO, aes(x = date, y = PPIACO))
    ## 
    ## > p13 <- p13 + geom_line(size = 2, color = "peru") + 
    ## +     theme_minimal() + scale_x_date(breaks = pretty_breaks(6)) + 
    ## +     scale_y_continuous(limi .... [TRUNCATED] 
    ## 
    ## > ggsave("../output/p13.png", p13)

    ## Saving 7 x 5 in image

### Finally, Print the Plots for Monday Morning Update: November 11, 2019

``` r
source("../code/200_Print report.R", echo = FALSE)
```

Back to **[Index](index.md)**

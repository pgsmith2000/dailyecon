# makeFREDtable(symbol, start.date, end.date)
makeFREDtable <- function(symbol, start.date, end.date) {
  
  df <- fredr(series_id = symbol,
              start.date,
              end.date)
  df$series_id <- NULL
  names(df)[2] <- symbol
  df <- fill(df, 2, .direction=c("downup"))
  
  return(df)
}

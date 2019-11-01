# load libraries
library(fredr)
library(quantmod)
library(gdata)
library(tidyverse)


# set FRED key
user_api_key<-read.csv("D:/RProjects/fred_api_key.csv", 
                       stringsAsFactors=TRUE, as.is=TRUE)
fredr_set_key(user_api_key$fredAPIkey)

get.FRSeriesTags <- function(seriesNam)
{
  #     seriesNam = character string containing the ID identifying the FRED series to be retrieved    
  #
  library("httr")
  library("jsonlite")
  # dummy FRED api key; request valid key from http://api.stlouisfed.org/api_key.html
  apiKey <- paste0("&api_key=", user_api_key, sep="")     
  base  <- "http://api.stlouisfed.org/fred/"
  seriesID <- paste("series_id=", seriesNam,sep="")
  fileType <- "&file_type=json"
  # 
  # get series descriptive data
  #
  datType <- "series?"
  url <- paste(base, datType, seriesID, apiKey, fileType, sep="")
  series <- fromJSON(url)$seriess
  # 
  # get series tag data
  #
  datType <- "series/tags?"
  url <- paste(base, datType, seriesID, apiKey, fileType, sep="")
  tags <- fromJSON(url)$tags
  #
  # format as excel descriptive rows
  #
  description <- data.frame(Title=series$title[1], 
                            Series_ID = series$id[1], 
                            Source = tags$notes[tags$group_id=="src"][1],
                            Release = tags$notes[tags$group_id=="gen"][1],
                            Frequency = series$frequency[1],
                            Units = series$units[1],
                            Date_Range = paste(series[1, c("observation_start","observation_end")], collapse=" to "),
                            Last_Updated = series$last_updated[1],
                            Notes = series$notes[1],
                            row.names=series$id[1])
  return(t(description))
}


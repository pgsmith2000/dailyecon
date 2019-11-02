# load libraries
library(fredr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(scales)
library(gridExtra)


# set FRED key
user_api_key<-read.csv("../../fred_api_key.csv", 
                       stringsAsFactors=TRUE, as.is=TRUE)
fredr_set_key(user_api_key$fredAPIkey)

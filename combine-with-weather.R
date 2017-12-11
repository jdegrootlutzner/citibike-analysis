---
title: "Team Bike"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


```{r warning=FALSE}
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(chron)
NYC <- read_csv("~/Desktop/compstats/ma154-project24-teambike/NYC.txt")

julycity <- read_csv("~/Downloads/2013-07 - Citi Bike trip data.csv")
```


```{r}
# Removing the extraneous variables
NYC <- NYC %>%
  select(-drct,-p01i,-skyc1,-skyc2,-skyc3,-skyc4,skyl1,-skyl2,-skyl2,-skyl3,-skyl4,-metar)

julycity <- julycity[-c(450:843416),]
julycity <- julycity %>%
  mutate(uid=substr(starttime,1,13))

NYC$valid <- parse_date_time(NYC$valid,orders = "ymd H:M:S")
julycity$starttime <- parse_date_time(julycity$starttime, orders = "ymd H:M:S")
julycity$stoptime <- parse_date_time(julycity$stoptime, orders = "ymd H:M:S")


NYC <- NYC %>%
  mutate(summer=ifelse(valid<"2013-08-30 23:59:00"&&valid>"2013-05-31",1,0)) %>%
  mutate(spring=ifelse((valid>"2013-03-01"&&valid<"2013-05-31"),1,0)) %>%
  mutate(winter=ifelse((valid>"2013-12-01"&&valid<"2014-02-27"),1,0)) %>%
  mutate(fall=ifelse((valid>"2013-08-31"&&valid<"2013-11-30"),1,0))
  
# Substringing the date and the time if need be 
NYC <- NYC %>%
  mutate(Month=substr(valid,6,7)) %>%
  mutate(date=substr(valid,1,10))

# Trying to Find Day of the Week
NYC <- NYC %>%
  mutate(WeekDay=wday(as.Date(valid), label=TRUE)) %>%
  mutate(WorkingDay=ifelse((WeekDay=="Mon"|WeekDay=="Tues"|WeekDay=="Wed"|WeekDay=="Thurs"|WeekDay=="Fri"),"Yes","No")) 

# Trying to find the holidays - Not quite working. Need to do this manually!
NYC <- NYC %>%
  mutate(holiday=is.holiday(valid))

# Trying to get hourly data - one observation per hour
NYC <- NYC %>%
  filter(minute(valid)=="51") %>%
  mutate(uid=substr(valid,1,13))


# Trying to create a unique identifier after which I can join the two DF's
NYC$uid <- parse_date_time(NYC$uid,orders = "ymd H")
julycity$starttime <- parse_date_time(julycity$uid, orders = "ymd H")
str(NYC$uid)
str(julycity$uid)

# So I'm joing the two df's based on the date and the hour. The uid identifier is the date and hour. 
a <- left_join(NYC,julycity,by="uid")

# take a look, I was able to join the two data frames based on the date and hour. I used hourly data when the minute is 51 to maintain uniformity.  
```

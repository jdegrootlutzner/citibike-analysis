# Removing the extraneous variables
NYC <- NYC %>%
  select(-drct,-p01i,-skyc1,-skyc2,-skyc3,-skyc4,skyl1,-skyl2,-skyl2,-skyl3,-skyl4,-metar)

julycity <- julycity[-c(450:843416),]
julycity <- julycity %>%
  mutate(uid=substr(starttime,1,13))

NYC$valid <- parse_date_time(NYC$valid,orders = "ymd H:M:S")
julycity$starttime <- parse_date_time(julycity$starttime, orders = "ymd H:M:S")
julycity$stoptime <- parse_date_time(julycity$stoptime, orders = "ymd H:M:S")

# Substringing the date and the time if need be. Making a new variable month, which will help to make variables for the season. 
NYC <- NYC %>%
  mutate(Month=month(valid)) %>%
  mutate(date=substr(valid,1,10))

# Making Binary Variables for the Seasons
NYC <- NYC %>%
  mutate(summer=ifelse(Month=="6"|Month=="7"|Month=="8",1,0)) %>%
  mutate(spring=ifelse((Month=="3"|Month=="4"|Month=="5"),1,0)) %>%
  mutate(winter=ifelse((Month=="1"|Month=="2"|Month=="12"),1,0)) %>%
  mutate(fall=ifelse((Month=="9"|Month=="10"|Month=="11"),1,0))
  
month(NYC$valid)


# Trying to Find Day of the Week
NYC <- NYC %>%
  mutate(WeekDay=wday(as.Date(valid), label=TRUE)) %>%
  mutate(WorkingDay=ifelse((WeekDay=="Mon"|WeekDay=="Tues"|WeekDay=="Wed"|WeekDay=="Thurs"|WeekDay=="Fri"),"Yes","No")) 

# Trying to find the holidays - Not quite working. Need to do this manually!
NYC <- NYC %>%
  mutate(holiday=is.weekend(valid))

# Trying to get hourly data - one observation per hour, instead of multiple observations
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

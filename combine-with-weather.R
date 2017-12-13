library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(chron)
NYC <- read_csv("~/Desktop/compstats/ma154-project24-teambike copy/NYC.txt")
practice <- read_excel("~/Desktop/practice.xlsx")
# Removing the extraneous variables
NYC <- NYC %>%
  select(-drct,-p01i,-skyc1,-skyc2,-skyc3,-skyc4,skyl1,-skyl2,-skyl2,-skyl3,-skyl4,-metar)
randomsample <- read_csv("~/Desktop/compstats/ma154-project24-teambike/final_project/randomsample.csv")


practice<- practice %>%
  mutate(uid=substr(starttime,1,13))

# Parsing the CitiBikes Data 
practice$starttime <- parse_date_time(practice$starttime, orders = "ymd H:M:S")
practice$stoptime <- parse_date_time(practice$stoptime, orders = "ymd H:M:S")
NYC$valid <- parse_date_time(NYC$valid, orders = "ymd H:M:S")

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
  

# Trying to Find Day of the Week
NYC <- NYC %>%
  mutate(WeekDay=wday(as.Date(valid), label=TRUE)) %>%
  mutate(WorkingDay=ifelse((WeekDay=="Mon"|WeekDay=="Tues"|WeekDay=="Wed"|WeekDay=="Thurs"|WeekDay=="Fri"),"Yes","No")) 

# Trying to find the holidays - Not quite working. Need to do this manually!
NYC <- NYC %>%
  mutate(holiday=is.weekend(valid))

# Trying to get hourly data - one observation per hour, instead of multiple observations
NYC <- NYC %>%
  filter(minute(valid)=="51") 

NYC <- NYC %>%
  mutate(uid=substr(valid,1,13)) 


# Trying to create a unique identifier after which I can join the two DF's

practice$uid <- parse_date_time(practice$uid,orders = "ymd H") 
NYC$uid <- parse_date_time(NYC$uid,orders = "ymd H")
# So I'm joing the two df's based on the date and the hour. The uid identifier is the date and hour. 
a <- left_join(NYC,practice,by="uid")

# take a look, I was able to join the two data frames based on the date and hour. I used hourly data when the minute is 51 to maintain uniformity.  
```

```{r}
# Parsing all the start times into one format
mdy <- mdy_hms(randomsample$starttime) 
ymd <- ymd_hms(randomsample$starttime) 
f1 <- mdy_hm(randomsample$starttime)
mdy[is.na(mdy)] <- ymd[is.na(mdy)] # some dates are ambiguous, here we give 
randomsample$starttime <- mdy
randomsample$starttime[is.na(randomsample$starttime)] <- f1[is.na(randomsample$starttime)]

# Parsing all the end times into one format 
mdy <- mdy_hms(randomsample$stoptime) 
ymd <- ymd_hms(randomsample$stoptime) 
f1 <- mdy_hm(randomsample$stoptime)
mdy[is.na(mdy)] <- ymd[is.na(mdy)] # some dates are ambiguous, here we give 
randomsample$stoptime <- mdy
randomsample$stoptime[is.na(randomsample$stoptime)] <- f1[is.na(randomsample$stoptime)]

# Cieling the Hour 
NYC <- NYC %>%
  mutate(valid=ceiling_date(NYC$valid, unit = "hour"))

# Number of Stations Every Year
rs <- randomsample %>%
  mutate(year=year(starttime)) %>%
  group_by(year,usertype) %>%
  summarise(stations=n_distinct(start.station.id),rides=n())

rs
# Plotting the expansion of Citi Bikes Across New York
ggplot(rs,aes(x=year,y=stations,fill=usertype))+geom_bar(stat="identity")+ylab("Number of Stations")+xlab("Station")+ggtitle("Expansion of Citi Bikes Across New York")

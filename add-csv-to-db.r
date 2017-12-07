# add

library(DBI)
library(RMySQL)
db <- dbConnect(MySQL(), dbname = "bike_data", user = "jdegroot", password = "", port = 3306)
dbWriteTable(db, name = "bike_data", value = "/home/jdegroot/bike_project2013-07 - Citi Bike trip data.csv")

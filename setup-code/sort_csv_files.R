require(RMySQL, dplyr)
conn <- dbConnect(MySQL(), dbname = "bike_data", port = 3306)
need_help_list <- scan("needHelp.txt", what= "character", sep="\n")
no_help_list <- scan("noHelp.txt", what= "character", sep="\n")
helpers =c()
for(j in 1:length(need_help_list)){
  helpers[j] <- (paste("output", j,".csv", sep = ""))
}

dbWriteTable(conn, name = "bike", overwrite = TRUE, value = need_help_list[1])
dbWriteTable(conn, name = "bike", append = TRUE, value = helpers[1])
message("Finished base files")
for(k in 2:length(need_help_list)){
  message(paste("Attempting: ", need_help_list[k]))
  dbWriteTable(conn, name = "bike", append = TRUE, value = need_help_list[k])
  message("Added.")
  message(paste("Attempting: ", helpers[k]))
  dbWriteTable(conn, name = "bike", append = TRUE, value = helpers[k])
  message("Added.")
}
message("Finished files that needed helpers.")
for(l in 1:length(no_help_list)){
  message(paste("Attempting: ", no_help_list[l]))
  dbWriteTable(conn, name = "bike", append = TRUE, value = no_help_list[l])
  message("Added.")
}
message("Done!")
message(dbGetQuery(conn, "SELECT count(*) FROM bike;"))

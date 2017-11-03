# NYC Bicycle Demand Prediction and Traffic Visualization

 **Final Project for ma154** *(Fall Semester 2017)*

*Team Members:* Julian DeGroot-Lutzner, Vikram Salwan


## Background & Motivation 
*(1) data centered, (2) tell us something, (3) do something new*

We have two goals. 
For one, we want to combine historical usage patterns of CitiBikes with weather data in order to forecast bike rental demand. This idea is based on a related Kaggle competition and will challenge us to use the material we are about to learn on statistical models and machine learning.
Secondly, we want to use Strava NYC Metro data about bicycle trips to understand if new bike paths affect bicycle patterns. This part of the project will be more about visualization as we will learn and use Shiny/Leaflet. We fill focus in on the hot spots that we find in usage of CitiBikes.

## Description of Dataset

[*Citi Bikes Data*](https://www.citibikenyc.com/system-data)

Variables : tripduration, starttime, stoptime, start station id, start station name, start station latitude, start station longitude, end station id, end station name, end station latitude, end station longitude, bikeid, usertype, birth year, gender
This data will be the beginning and base of our project. Most of the variables are self explanatory but we will further explain the variables in our final project proposal. We will first combine this data with historical weather data to create our model.
What is the best way to get weather data for NYC? We think the NOAA but would love to hear your advice.

[*Strava Data*](https://stravametro.exavault.com/share/view/h48l-5hq0lubm?utm_source=hs_automation&utm_medium=email&utm_content=29456275&_hsenc=p2ANqtz-_OhD5MxKs_x5i-U9ucr5ZAD4SnLJHROjk492autxIpQctBaN7UQ9NgmEyZe5vB2vfXWeMXlEpqUSQ261M5A1VsTc1eJyXF-qQ90LilJ8eP8XdofKQ&_hsmi=29456275)

This data is much more complex than the Citi Bikes data. There is a 40 page manual on understanding it. The data is spatial data and includes a list of nodes, edges, and polygons. It will give us insight into the ways that people move between Citi Bike locations. It will provide great resources for visualization. 

*Bike Path Data*

This is where the high reach goals of our project begin. NYC DOT provides [a list](http://home2.nyc.gov/html/dot/html/bicyclists/lane-list.shtml?) of all the bike paths, and the [historical records](http://www.nyc.gov/html/dot/html/bicyclists/past-bike-projects.shtml) of when these bike paths were created. We will try to find a bike path that was completed during the dates of the Strava data we have. Then we will be able to visualize the difference in traffic patterns in the neighborhood around the bike path before and after the bike path was created. We will probably not even need to bring the dataset into R as we will look through it manually. The visualization will be the difficult part.


## Expected Work/Deliverables
Our final project will be a predictive model, a Shiny applet online about the impact of bike paths, and a write up about our process, difficulties, and conclusion.


## Expected Background Materials/Resources
* 


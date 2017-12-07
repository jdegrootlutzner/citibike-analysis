'''
 Simple Python code to return a file of all the links to the Citbikes data to
 be downloaded.

 @author Julian DeGroo-Lutzner
 @date Dec 3, 2017

'''
def convert_to_month(int):
    if int < 10 :
        int = '%0*d' % (2, int)
    else:
        int = str(int)
    return int

def makeLinks():
    output_text = open("links.txt", "w")
    # Add year 2013
    for month in range(7, 13):
        output_text.write("https://s3.amazonaws.com/tripdata/2013" +
        convert_to_month(month) +
        "-citibike-tripdata.zip\n")
    # Add years 2014-2016
    for year in range(2014, 2016):
        for month in range(1, 13):
            output_text.write("https://s3.amazonaws.com/tripdata/" +
            str(year) +
            convert_to_month(month) +
            "-citibike-tripdata.zip\n")
    # Add year 2017
    for month in range(1, 9):
        output_text.write("https://s3.amazonaws.com/tripdata/2017" +
        convert_to_month(month) +
        "-citibike-tripdata.csv.zip\n")
    output_text.close()

def makeZips():
    output_text = open("zips.txt", "w")
    # Add year 2013
    for month in range(7, 13):
        output_text.write("2013" +
        convert_to_month(month) +
        "-citibike-tripdata.zip\n")
    # Add years 2014-2016
    for year in range(2014, 2016):
        for month in range(1, 12):
            output_text.write(str(year) +
            convert_to_month(month) +
            "-citibike-tripdata.zip\n")
    # Add year 2017
    for month in range(1, 9):
        output_text.write("2017" +
        convert_to_month(month) +
        "-citibike-tripdata.csv.zip\n")
    output_text.close()

makeLinks()
makeZips()

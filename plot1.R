## exdata-014 Assignment 1 part 1
## code for plot 1

##### This section is the same for all plots #####
##### BEGIN

# get source data
if (!file.exists("exdata-data-household_power_consumption.zip")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        destfile="exdata-data-household_power_consumption.zip",
        method="curl")
    unzip("exdata-data-household_power_consumption.zip")  
}

# unzipped text/csv file has name "household_power_consumption.txt"
# values are separated with ";"

# just to get the column names
headers <- read.csv("household_power_consumption.txt", 
    sep=";", 
    header=TRUE, 
    nrows=1)

# missing values are coded as "?"
# plots use data from 2007-02-01 and 2007-02-02, which are in rows 66638 - 69517 
#   of the unzipped text file (2880 rows of data). This is not the best way to
#   do it but the point of the assignment is the plotting, and is a shortcut to
#   the alternative of reading in the whole table and subsetting the 2 dates.

data <- read.table("household_power_consumption.txt", 
    sep=";",
    skip=66637,
    nrows=2880,
    header=FALSE,
    as.is=TRUE,
    na.strings="?",
    col.names=colnames(headers))

# add column with date and time in proper date/time format,
# update date column to be proper date format
data$dateTime <- strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
data$Date <- strptime(data$Date, "%d/%m/%Y")

##### This section is the same for all plots #####
##### END

# perform plot
png(filename="plot1.png", width=480, height=480)
with(data, hist(Global_active_power, 
    col="red",
    xlab="Global Active Power (kilowatts)",
    main="Global Active Power"))
dev.off()

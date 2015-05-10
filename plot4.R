## exdata-014 Assignment 1 part 4
## code for plot 4

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
png(filename="plot4.png", width=480, height=480)
par(mfrow = c(2,2))

# top left plot (pretty much same as part 2)
with(data, plot(dateTime, 
                Global_active_power, 
                type="l",
                col="black", 
                xlab="", 
                ylab="Global Active Power", 
                main=""))

# top right plot
with(data, plot(dateTime, 
                Voltage, 
                type="l",
                col="black", 
                xlab="datetime", 
                ylab="Voltage", 
                main=""))

# bottom left plot (same as part 3)
with(data, plot(dateTime, 
    Sub_metering_1, 
    type="l",
    col="black", 
    xlab="",
    ylab="Energy sub metering", 
    main=""))
with(data, points(dateTime,
    Sub_metering_2,
    type="l",
    col="red"))
with(data, points(dateTime,
    Sub_metering_3,
    type="l",
    col="blue"))
legend("topright",
    lty=1,
    col=c("black", "red", "blue"),
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# bottom right plot
with(data, plot(dateTime, 
                Global_reactive_power, 
                type="l",
                col="black", 
                xlab="datetime", 
                main=""))
dev.off()

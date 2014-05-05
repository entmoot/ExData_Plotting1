## Eploratory data analysis coursera course
## Course project 1 solution - part1 
## May 2014


## if there is no data in expected location, download it 
## and extract into folder data

if(!file.exists("data"))
{
  dir.create("data")
}
if(!file.exists("data/electricity.zip"))
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",dest="data/electricity.zip", mode="wb")
  library(utils)
  
  unzip("./data/electricity.zip", exdir="./data")
}

## read in only the data from row 66637 to row 69516 because there are
## the rows with dates 2007-02-01 and 2007-02-02 (rows found using the binary search)

data=read.table("data/household_power_consumption.txt", sep=";",na.strings="?",skip=66637,nrow=2880,
                 colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## read in the header names (which were ignored in the row-skipping read above)
headers=read.table("data/household_power_consumption.txt",sep=";",nrow=1, header=T)

names(data)<-names(headers)

## transform the dates and times from strings to the datetime format

data$time=strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
data$Time=NULL
data$Date=NULL

## plotting the first plot to the PNG graphic device

png(filename = "plot1.png",width = 480, height = 480, units = "px",type="cairo")

hist(data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")

dev.off()

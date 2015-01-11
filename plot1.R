#downloading file
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="data.zip")

# uzip the file
unzip("data.zip")

#reading the data
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";");
data$Date <- as.Date(data$Date,"%d/%m/%Y")
targetData<-subset(data,Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))
targetData$Global_active_power <- as.numeric(as.character(targetData$Global_active_power))

# saving as plot1.png (480*480)
png(file="plot1.png")
# drawing histogram
hist(targetData$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kiowatts)")
# close the device
dev.off()

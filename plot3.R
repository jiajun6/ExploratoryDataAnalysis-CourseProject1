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
targetData$Time = paste(targetData$Date,targetData$Time)
targetData$Time <- strptime(targetData$Time,"%Y-%m-%d %H:%M:%S")
targetData$Sub_metering_1 <- as.numeric(as.character(targetData$Sub_metering_1))
targetData$Sub_metering_2 <- as.numeric(as.character(targetData$Sub_metering_2))
targetData$Sub_metering_3 <- as.numeric(as.character(targetData$Sub_metering_3))

#saving as plot3.png
png(file="plot3.png")
with(targetData,plot(Time,Sub_metering_1,type="l",col="black",ylab="Energy sub metering"),xlab="")
with(subset(targetData),points(Time,Sub_metering_2,col="red",type="l"))
with(subset(targetData),points(Time,Sub_metering_3,col="blue",type="l"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()


#downloading file
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="data.zip")

# uzip the file
unzip("data.zip")

#reading the data
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";");
data$Date <- as.Date(data$Date,"%d/%m/%Y")
targetData<-subset(data,Date==as.Date("2007-02-01")|Date==as.Date("2007-02-02"))

targetData$Time = paste(targetData$Date,targetData$Time)
targetData$Time <- strptime(targetData$Time,"%Y-%m-%d %H:%M:%S")
targetData$Global_active_power <- as.numeric(as.character(targetData$Global_active_power))
targetData$Sub_metering_1 <- as.numeric(as.character(targetData$Sub_metering_1))
targetData$Sub_metering_2 <- as.numeric(as.character(targetData$Sub_metering_2))
targetData$Sub_metering_3 <- as.numeric(as.character(targetData$Sub_metering_3))


## plot 4
par(mfrow=c(2,2))
attach(targetData)
hist(targetData$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kiowatts)")
plot(Time,Voltage,xlab="datetime",ylab="Voltage",type="l")
plot(Time,Sub_metering_1,type="l",col="black",ylab="Energey sub metering",xlab="")
points(Time,Sub_metering_2,col="red",type="l")
points(Time,Sub_metering_3,col="blue",type="l")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(Time,Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
detach(targetData)

## close
dev.copy(png,file="./plot4.png")
dev.off()

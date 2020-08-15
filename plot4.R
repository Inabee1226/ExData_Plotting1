###Read data from desktop and convert to dataframe
x<- read.table("/Users/Yoshinori/Desktop/household_power_consumption.txt",sep=";",header = TRUE,stringsAsFactors = FALSE)
x<- tbl_df(x)

###Filter data for 2007 Feb 1st and Feb 2nd
xx<-subset(x,Date == "2/2/2007"|Date== "1/2/2007" )

###Define datatype and add column for plot2-plot4
xxx <- transform(xx, Date=as.character(Date),Time=as.character(Time),Global_active_power=as.numeric(Global_active_power),
                 Global_reactive_power=as.numeric(Global_reactive_power),Voltage=as.numeric(Voltage),
                 Global_intensity=as.numeric(Global_intensity),Sub_metering_1=as.numeric(Sub_metering_1),
                 Sub_metering_2==as.numeric(Sub_metering_2),Sub_metering_3==as.numeric(Sub_metering_3)
)

xxx <- mutate(xxx, Date_Time = paste(Date, Time, sep = " "))
xxx$Date_Time <- strptime(xxx$Date_Time, "%d/%m/%Y %H:%M:%S")

###Plot4
par(mfrow = c(2,2))
plot(xxx$Date_Time, xxx$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
plot(xxx$Date_Time, xxx$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(xxx$Date_Time, xxx$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
points(xxx$Date_Time, xxx$Sub_metering_2, type = "l", col = "red")
points(xxx$Date_Time, xxx$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.75)

plot(xxx$Date_Time, xxx$Global_reactive_power,
     type = "l", ylab = "Global reactive power", xlab = "datetime")
## Read the file and assign the header to the dataframe as per need

df_file1<-read.table("household_power_consumption.txt",sep=";",skip = 1,col.names = c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3"))

print("file read complete")
## Move the data frame to table class

df_table<-tbl_df(df_file1)

library(dplyr)

##Convert the date format and column numeric format. Also filter the data to only for two days

power_consumption<-df_table%>%mutate(global_active_power=as.numeric(na_if(as.vector(global_active_power),"?")),global_reactive_power=as.numeric(na_if(as.vector(global_reactive_power),"?")),voltage=as.numeric(na_if(as.vector(voltage),"?")),global_intensity=as.numeric(na_if(as.vector(global_intensity),"?")),sub_metering_1=as.numeric(na_if(as.vector(sub_metering_1),"?")),sub_metering_2=as.numeric(na_if(as.vector(sub_metering_2),"?")),date_time=as.POSIXct(paste(date,time,sep =" "),"%d/%m/%Y %H:%M:%S",tz="")) %>%filter(date_time>='2007-02-01' & date_time<'2007-02-03')%>%select(date_time,global_active_power,global_reactive_power,voltage,global_intensity,sub_metering_1,sub_metering_2,sub_metering_3)

print("dataframe filter complete")

##Set the margin and create the histogram

par(mfrow=c(2,2),mar=c(4,4,2,2))

png("plot4.png",height=480,width=480,units = "px")

par(mfrow=c(2,2),mar=c(4,4,2,2))

plot(power_consumption$date_time,power_consumption$global_active_power,type="l",ylab="Global Active Power",xlab="")


plot(power_consumption$date_time,power_consumption$voltage,type="l",ylab="voltage",xlab="datetime")

plot(power_consumption$date_time,power_consumption$sub_metering_1,type="l",ylim=c(0,40),ylab="Energy sub metering",xlab="")
par(new="TRUE")
plot(power_consumption$date_time,power_consumption$sub_metering_2,type="l",ylim=c(0,40),xlab="",ylab="",col="red")
par(new="TRUE")
plot(power_consumption$date_time,power_consumption$sub_metering_3,type="l",ylim=c(0,40),xlab="",ylab="",col="blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),col=c("black","red","blue"),lty=1,cex=0.5)

plot(power_consumption$date_time,power_consumption$global_reactive_power,type="l",ylab="global_reactive_power",xlab="datetime")

dev.off()



print("Plot Created")

remove(df_file1,df_table)
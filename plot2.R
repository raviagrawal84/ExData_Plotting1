## Read the file and assign the header to the dataframe as per need

df_file1<-read.table("household_power_consumption.txt",sep=";",skip = 1,col.names = c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering_1","sub_metering_2","sub_metering_3"))

print("file read complete")
## Move the data frame to table class

df_table<-tbl_df(df_file1)

library(dplyr)

##Convert the date format and column numeric format. Also filter the data to only for two days

plot2_df<-df_table%>%mutate(global_active_power=as.numeric(na_if(as.vector(global_active_power),"?")),global_reactive_power=as.numeric(na_if(as.vector(global_reactive_power),"?")),voltage=as.numeric(na_if(as.vector(voltage),"?")),global_intensity=as.numeric(na_if(as.vector(global_intensity),"?")),sub_metering_1=as.numeric(na_if(as.vector(sub_metering_1),"?")),sub_metering_2=as.numeric(na_if(as.vector(sub_metering_2),"?")),date_time=as.POSIXct(paste(date,time,sep =" "),"%d/%m/%Y %H:%M:%S",tz="")) %>%filter(date_time>='2007-02-01' & date_time<'2007-02-03')%>%select(date_time,global_active_power,global_reactive_power,voltage,global_intensity,sub_metering_1,sub_metering_2,sub_metering_3)

print("dataframe filter complete")

##Set the margin and create the histogram

par(mfrow=c(1,1),mar=c(2,3,2,2))

png("plot2.png",height=480,width=480,units = "px")

plot(plot2_df$date_time,plot2_df$global_active_power,type="l",ylab="Global Active Power(killowatts)")

dev.off()



print("Plot Created")

remove(df_file1,df_table)
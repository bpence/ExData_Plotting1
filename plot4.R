################################################################################
# Load dplyr library                                                           #
################################################################################

library(dplyr)


################################################################################
# Open the PNG graphics device                                                 #
################################################################################

png(filename="plot4.png", width=480, height=480, unit="px", pointsize=12,
    bg="white")


################################################################################
# Read the data and filter for appropriate dates                               #
################################################################################

dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
dat[,1] <- as.character(dat[,1])
dat[,2] <- as.character(dat[,2])
dat <- rbind(dat[which(dat[,1]=="1/2/2007"),],dat[which(dat[,1]=="2/2/2007"),])


################################################################################
# Convert dates to POSIXct format                                              #
################################################################################

date <- as.Date(dat[,1], format="%d/%m/%Y")
datetime <- format(as.POSIXct(paste(date, dat[,2])), "%a %d/%m/%Y %H:%M:%S")


################################################################################
# Add datetime column                                                          #
################################################################################

dat <- mutate(dat, datetime = datetime)


################################################################################
# Sets some parameters for the graphs                                          #
################################################################################

par(ps=12, mfrow=c(2,2))


################################################################################
# Convert the Global Active Power column to numeric and sets it to x           #
################################################################################

dat[,"Global_active_power"] <- as.numeric(as.character(dat[,"Global_active_power"]))
y <- dat$Global_active_power
x <- seq(1,length(dat$datetime),1)
xbreak <- c("Thu","Fri","Sat")
breaks <- c(1,max(x)/2+1,max(x))


################################################################################
# Plots the first plot (upper left)                                            #
################################################################################

plot(x=x, y=y, type="l", ylab="Global Active Power", xlab="",
     xaxt="n")
axis(1, at=breaks, labels=xbreak)


################################################################################
# Plots the second plot (upper right)                                          #
################################################################################

y2 <- as.numeric(as.character(dat[,"Voltage"]))
plot(x=x, y=y2, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
axis(1, at=breaks, labels=xbreak)


################################################################################
# Convert the Sub metering columns to numeric and sets them to sm1 - sm3       #
################################################################################

sm1 <- as.numeric(as.character(dat[,"Sub_metering_1"]))
sm2 <- as.numeric(as.character(dat[,"Sub_metering_2"]))
sm3 <- as.numeric(as.character(dat[,"Sub_metering_3"]))


################################################################################
# Plots the third plot (lower left)                                            #
################################################################################

groups <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") # for legend groups
plot(0, type="n", ylab="Energy sub metering", xlab="",xaxt="n", xlim=c(1,max(x)), 
     ylim=c(0,38)) #empty plot

lines(sm1, type="l", col="black") # adds sub metering 1
lines(sm2, type="l", col="#FB3207") # adds sub metering 2
lines(sm3, type="l", col="blue") # adds sub metering 3
axis(1, at=breaks, labels=xbreak) # adds x axis
legend(x="topright", legend=groups, bty="n", lty=1,
       col=c("black", "#FB3207", "blue"), cex=0.9) # adds legend


################################################################################
# Plots the fourth plot (lower right)                                          #
################################################################################

y3 <- as.numeric(as.character(dat[,"Global_reactive_power"]))
plot(x=x,y=y3, type="l", ylab="Global_reactive_power", xlab="datetime", xaxt="n")
axis(1, at=breaks, labels=xbreak)


################################################################################
# Close the PNG graphics device                                                #
################################################################################

dev.off()







################################################################################
# Load dplyr library                                                           #
################################################################################

library(dplyr)


################################################################################
# Open the PNG graphics device                                                 #
################################################################################

png(filename="plot2.png", width=480, height=480, unit="px", pointsize=12,
    bg="transparent")


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
# Convert the Global Active Power column to numeric and sets it to y           #
################################################################################

dat[,"Global_active_power"] <- as.numeric(as.character(dat[,"Global_active_power"]))
y <- dat$Global_active_power


################################################################################
# Set breaks for x-axis in plot                                                #
################################################################################

x <- seq(1,length(dat$datetime),1)
xbreak <- c("Thu","Fri","Sat")
breaks <- c(1,max(x)/2+1,max(x))


################################################################################
# Generate the plot with appropriate formatting                                #
################################################################################

par(ps=14, bty="n")
plot(x=x, y=y, type="l", ylab="Global Active Power (kilowatts)", xlab="",
     xaxt="n")
axis(1, at=breaks, labels=xbreak)


################################################################################
# Close the PNG graphics device                                                #
################################################################################

dev.off()







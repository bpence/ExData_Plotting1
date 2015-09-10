################################################################################
# Open the PNG graphics device                                                 #
################################################################################

png(filename="plot1.png", width=480, height=480, unit="px", pointsize=12,
    bg="transparent")


################################################################################
# Read the data and filter for appropriate dates                               #
################################################################################

dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
dat[,1] <- as.character(dat[,1])
dat[,2] <- as.character(dat[,2])
dat <- rbind(dat[which(dat[,1]=="1/2/2007"),],dat[which(dat[,1]=="2/2/2007"),])


################################################################################
# Convert the Global Active Power column to numeric and sets it to x           #
################################################################################

dat[,"Global_active_power"] <- as.numeric(as.character(dat[,"Global_active_power"]))
x <- dat$Global_active_power


################################################################################
# Generate the histogram with appropriate formatting                           #
################################################################################

breaks <- c(seq(0,8,0.5))
par(ps=12)
hist(x, xlim=c(0,7.5), xlab="Global Active Power (kilowatts)",
     ylab="Frequency", main="Global Active Power", freq=TRUE,
     breaks=breaks, col="#FB3207")


################################################################################
# Close the PNG graphics device                                                #
################################################################################

dev.off()

# Download and unzip the dataset:

fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile = "./data/household_power_consumption.zip"
dataset = "./data/household_power_consumption.txt"

if (!file.exists("data")) {
    dir.create("data")
}

if (!file.exists(destfile)) {
    download.file(fileURL, destfile)
    dateDownloaded <- date()
}

if (!file.exists(dataset)) { 
    unzip(destfile, exdir = "./data") 
}

# Getting full dataset:
data <- read.csv(dataset, header = TRUE, sep = ";", na.strings = "?")

# Subsetting the data:
subdata <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]

# Converting dates:
datetime <- paste(as.Date(subdata$Date, format="%d/%m/%Y"), subdata$Time)
subdata$Datetime <- as.POSIXct(datetime)

# Plot 2:
plot2 <- function() {
    par(mfrow = c(1, 1), bg = NA, cex = 0.8)
    plot(subdata$Global_active_power ~ subdata$Datetime, type = "l",
         xlab = "", ylab = "Global Active Power (kilowatts)")
    # Saving to file:
    dev.copy(png, file = "plot2.png", width = 480, height = 480)
    dev.off()
    cat("plot2.png has been saved in", getwd())
}
plot2()
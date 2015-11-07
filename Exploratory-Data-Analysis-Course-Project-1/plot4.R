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

# Plot 4:
plot4 <- function() {
    par(mfrow = c(2, 2), bg = NA, cex = 0.6)
    # Global Active Power
    plot(subdata$Global_active_power ~ subdata$Datetime, type = "l", 
         xlab = "", ylab = "Global Active Power")
    # Voltage:
    plot(subdata$Voltage ~ subdata$Datetime, type = "l",
         xlab = "datetime", ylab = "Voltage")
    # Energy sub metering:
    plot(subdata$Sub_metering_1 ~ subdata$Datetime, type = "l",
         xlab = "", ylab = "Energy sub metering")
    lines(subdata$Sub_metering_2 ~ subdata$Datetime, col = "red")
    lines(subdata$Sub_metering_3 ~ subdata$Datetime, col = "blue")
    legend("topright", col = c("black","red","blue"), 
           c("Sub_metering_1   ", "Sub_metering_2   ", "Sub_metering_3   "),
           lty = c(1, 1), lwd = c(1, 1), bty = "n")
    # Global Reactive Power:
    plot(subdata$Global_reactive_power ~ subdata$Datetime, type = "l",
         xlab = "datetime", ylab = "Global_reactive_power")
    # Saving to file:
    dev.copy(png, file = "plot4.png", width = 480, height = 480)
    dev.off()
    cat("plot4.png has been saved in", getwd())
}
plot4()
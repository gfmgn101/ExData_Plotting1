if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/householdpower.zip")
unzip("./data/householdpower.zip", exdir = "./data")
dt <- read.table("./data/household_power_consumption.txt", sep=";", skip = 66637, na.strings ="?", nrow = 2880, header = FALSE, stringsAsFactors = FALSE)
namerow <- read.table("./data/household_power_consumption.txt", sep=";", nrow = 1, header = FALSE, stringsAsFactors = FALSE)
namerowlist <- as.character(namerow[1,])
names(dt) <- namerowlist
dt$Date <- as.Date(dt$Date, format = '%d/%m/%Y')
dt$dateTime <- as.POSIXct(paste(dt$Date, dt$Time))
dt <- dt[,c(1,2,10,3,4,5,6,7,8,9)] #rearrange order of columns

#line plot, x label and main title specified
with(dt, plot(dateTime, dt$Sub_metering_1,col = "black", type = 'l', ylab = "Energy sub metering", xlab = ""))
lines(dt$dateTime, dt$Sub_metering_2, col = "red")
lines(dt$dateTime, dt$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty = 1)

#create png
dev.copy(png, file = "plot3.png", height=480, width=480)
dev.off()


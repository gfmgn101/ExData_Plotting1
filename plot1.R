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

#histogram, color = red, x label and main title specified
hist(dt$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#create png
dev.copy(png, file = "plot1.png")
dev.off()


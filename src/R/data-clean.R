
# Set current working directory
baseDir <-"/home/brough/USU/Research/Projects/local/MGRM/" 
setwd(baseDir)

###### Gas Data ######

# Read Gasoline data
infile1 <- paste(baseDir, "data/December/gasoline-spot.csv", sep="")
gas.s.raw <- read.csv(infile1)
infile2 <- paste(baseDir, "data/December/gasoline-futures.csv", sep="")
gas.f.raw <- read.csv(infile2)

# Fix dates
gas.s.raw$Date <- as.Date(gas.s.raw$Date, "%Y-%m-%d")
gas.f.raw$Date <- as.Date(gas.f.raw$Date, "%Y-%m-%d")

# Merge the two
gas.c.raw <- merge(gas.s.raw, gas.f.raw, by="Date")
names(gas.c.raw) <- c("Date", "Spot", "Futures")

# Subset the dates
begDate <- as.Date("1991-12-01", "%Y-%m-%d")
endDate <- as.Date("2001-12-01", "%Y-%m-%d")
ind <- (gas.c.raw$Date >= begDate) & (gas.c.raw$Date <= endDate)
gas.c.sub <- gas.c.raw[ind, c(2,3)]

# Save to file
outfile1 <- paste(baseDir, "data/December/gas.csv", sep="")
write.csv(gas.c.sub, file = outfile1, quote=F, row.names=F)

###### Heating Oil Data ######

# Read heatingoil data
infile1 <- paste(baseDir, "data/December/heatingoil-spot.csv", sep="")
oil.s.raw <- read.csv(infile1)
infile2 <- paste(baseDir, "data/December/heatingoil-futures.csv", sep="")
oil.f.raw <- read.csv(infile2)

# Fix dates
oil.s.raw$Date <- as.Date(oil.s.raw$Date, "%Y-%m-%d")
oil.f.raw$Date <- as.Date(oil.f.raw$Date, "%Y-%m-%d")

# Merge the two
oil.c.raw <- merge(oil.s.raw, oil.f.raw, by="Date")
names(oil.c.raw) <- c("Date", "Spot", "Futures")

# Subset the dates
begDate <- as.Date("1991-12-01", "%Y-%m-%d")
endDate <- as.Date("2001-12-01", "%Y-%m-%d")
ind <- (oil.c.raw$Date >= begDate) & (oil.c.raw$Date <= endDate)
oil.c.sub <- oil.c.raw[ind, c(2,3)]

# Save to file
outfile1 <- paste(baseDir, "data/December/oil.csv", sep="")
write.csv(oil.c.sub, file = outfile1, quote=F, row.names=F)
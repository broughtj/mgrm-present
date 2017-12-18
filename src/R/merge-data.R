# Set current working directory
setwd("/home/brough/USU/Research/Projects/local/MGRM/src/R")


# Read in both raw datasets
da.raw <- read.table("DA-Daily-Nearest.csv", sep=",", header=T)
dl.raw <- read.table("DL-Daily-Nearest.csv", sep=",", header=T)
bj.raw <- read.table("BJ-Daily-Nearest.csv", sep=",", header=T)


# Clean up cheese data
bj.tmp <- data.frame(date=bj.raw$tradingDay, cheese=bj.raw$close)
bj.tmp$date <- as.Date(bj.tmp$date)
#bj.tmp$cheese <- log(bj.tmp$cheese)

# Clean up milk data (DL -> "exchange")
dl.tmp <- data.frame(date=dl.raw$tradingDay, milk=dl.raw$close)
dl.tmp$date <- as.Date(dl.tmp$date)
dl.tmp$milk <- dl.tmp$milk / 10

# Clean up milk data (DA -> "pit")
da.tmp <- data.frame(date=da.raw$tradingDay, prc=da.raw$close)
da.tmp$date <- as.Date(da.tmp$date)
da.tmp$prc <- da.tmp$prc / 10

# Merge the datasets into a single data frame
dat <- merge(dl.tmp, da.tmp, by="date")
dat <- merge(dat, bj.tmp, by="date")
dat$basis <- dat$cheese - dat$milk
nr <- nrow(dat)

# Plot
plot(dat$cheese, lwd=3, type="l", col="blue",ylim=c(0, 3))
lines(dat$milk, lwd=3, type="l", col="green")
lines(dat$basis, lwd=3, type="l", col="red")

# De-seasonalize the prices
library(lubridate)
mos <- month(dat$date)
cal <- matrix(0, nrow=nr, ncol=12)

for(i in 1:12)
{
	idx <- (mos == i)
	cal[idx,i] <- 1
}

dat.cal <- data.frame(cbind(dat$cheese, cal))
names(dat.cal) <- c("cheese", "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec")
fit <- lm(cheese ~ jan + feb + mar + apr + may + jun + jul + aug + sep + oct + nov + dec - 1, data = dat.cal)
y <- fit$residuals
plot(y, lwd=3, type="l", col="blue")





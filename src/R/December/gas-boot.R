StationaryBootstrap <- function(y = "numeric", p = "numeric")
{
  ii <- 1:length(y)
  ind <- sample(ii, size = length(y), replace=T)
  u <- runif(length(y))
  
  for(i in 2:length(y))
  {
    if(u[i] > p)
    {
      ind[i] <- ind[i-1] + 1
      if(ind[i] >= length(y))
        ind[i] <- 0
    }
  }
  
  return(ind)
}


## Main ##
baseDir <-"/home/brough/USU/Research/Projects/local/MGRM/"
infile <- paste(baseDir, "data/December/gas.csv", sep="")
gas.raw <- read.csv(infile, sep=",", header=F)
names(gas.raw) <- c("Spot", "Futures")


## Bootstrap the series and store in a list (convert to DataFrame)
gas.s.sim <- list()
gas.f.sim <- list()
B <- 10

spot <- diff(log(gas.raw$Spot))
futures <- diff(log(gas.raw$Futures))

for(b in 1:B)
{
  ind <- StationaryBootstrap(spot, 0.1)
  gas.s.sim[[b]] <- spot[ind]
  gas.f.sim[[b]] <- futures[ind]
}

## Back to DataFrames
gas.s.df <- do.call(rbind.data.frame, gas.s.sim)
gas.f.df <- do.call(rbind.data.frame, gas.f.sim)


# Save to file
outfile1 <- paste(baseDir, "data/December/gas-spot-sim.csv", sep="")
write.csv(file = outfile1, x = gas.s.df, row.names=F, quote=F)
outfile2 <- paste(baseDir, "data/December/gas-futures-sim.csv", sep="")
write.csv(file = outfile2, x = gas.f.df, row.names=F, quote=F)

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

SimulateAR <- function(rho = "numeric", initVal = "numeric", len.out = "numeric")
{
	y <- rep(0, len.out)
	y[1] <- initVal
	z <- rnorm(len.out)

	for(i in 2:len.out)
	{
		y[i] <- rho * y[i-1] + z[i]
	}

	return(y)
}


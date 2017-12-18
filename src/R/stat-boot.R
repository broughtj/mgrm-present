StationaryBootstrap <- function(u, q)
{
  
  return ii
}

SimulateAR <- function(y.init, rho, reps)
{
  y <- rep(0, reps)
  y[1] <- y.init
  u <- rnorm(reps)
  
  for(i in 2:reps)
  {
    y[i] <- rho * y[i-1] + u[i]
  }
  
  return(y)
}

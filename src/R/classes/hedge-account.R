HedgeAccount <- setRefClass("HedgeAccount",
	fields = list(refPrc = "numeric", 
				  initMargin = "numeric",
				  varMargin = "numeric",
				  numContracts = "numeric",
				  units = "numeric",
				  equity = "numeric",
				  capital = "numeric",
				  profit = "numeric",
				  cumProfit = "numeric",
				  marginCall = "numeric",
				  day = "numeric"
	),

	methods = list(
		initialize = function(refPrc_, initMargin_, varMargin_, numContracts_, units_) 
		{
			refPrc <<- refPrc_
			initMargin <<- initMargin_
			varMargin <<- varMargin_
			numContracts <<- numContracts_
			units <<- units_
			equity <<- initMargin_
			capital <<- initMargin_ 
			profit <<- 0.0
			cumProfit <<- 0.0
			marginCall <<- 0.0
			day <<- 0
		},
		update = function(spotPrc = "numeric")
		{
			day <<- day + 1
			profit <<- (spotPrc - refPrc) * (numContracts * units)
			cumProfit <<- cumProfit + profit
			equity <<- capital + cumProfit

			marginCall <<- 0.0
			if(equity <= varMargin)
			{
				marginCall <<- (initMargin - equity)
			}

			capital <<- capital + marginCall
			refPrc <<- spotPrc
		},
		show = function()
		{
			print(sprintf("Day t = %d", day))
			print(sprintf("--------------"))
			print(sprintf("Spot Price: %f", refPrc))
			print(sprintf("Profit: %f", profit))
			print(sprintf("Cumulative Profit: %f", cumProfit))
			print(sprintf("Capital: %f", capital))
			print(sprintf("Equity: %f", equity))
			print(sprintf("Margin Call: %f", marginCall))
			print("")	
		}
	)
)


## main
price <- 2.75
prices <- c(2.76, 2.73, 2.68, 2.67, 2.69, 2.64, 2.62, 2.63, 2.67)
initMargin <- 2000
varMargin <- 1750
numContracts <- 1
units <- 5000
acc <- HedgeAccount$new(price, initMargin, varMargin,numContracts , units)

acc$show()

for(i in 1:length(prices))
{
	acc$update(prices[i])
	acc$show()
}


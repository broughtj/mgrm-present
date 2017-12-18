#include <armadillo>
#include <iostream>
#include <vector>


std::vector<unsigned long> RandomIntegers(const unsigned long& num)
{
	std::random_device rd;
	std::mt19937 gen(rd());
	std::uniform_int_distribution<> dist(1, num - 1);
	std::vector<unsigned long> indices(num);

	for(unsigned long i = 0; i < num; ++i)
	{
		indices[i] = dist(gen);
	}

	return indices;
}

arma::mat StationaryBootstrap(const arma::mat& data, const double& p)
{
	auto nrows = data.n_rows;
	auto ncols = data.n_cols;
	arma::vec u(nrows, arma::fill::randu);
	auto indices = RandomIntegers(nrows);
	arma::mat path = arma::zeros<arma::mat>(nrows, ncols);

	for(auto i = 1; i < nrows; ++i)
	{
		if(u(i) > p)
		{
			indices[i] = indices[i-1] + 1;
			if(indices[i] == nrows)
			{
				indices[i] = 0;
			}
		}
		path.row(i) = data.row(indices[i]);
	}

	return path;
}

double ProfitLossFunction(arma::mat& dat, double hstar)
{
	arma::vec tmp1 = dat.col(0) - hstar * dat.col(1);
	arma::vec tmp2 = dat.col(0);
	auto num = dat.n_rows;	
	double profit = 0.0;

	for(auto i = 0; i < num; ++i)
	{
		profit += std::log(1.0 + tmp1(i)) - std::log(1.0 + tmp2(i));
	}
	
	profit /= num;

	return profit;
}

double VolatilityLossFunction(arma::mat& dat, double hstar)
{
	arma::vec tmp1 = dat.col(0) - hstar * dat.col(1);
	arma::vec tmp2 = dat.col(0);
	auto num = dat.n_rows;	
	double vol = 0.0;

	for(auto i = 0; i < num; ++i)
	{
		vol += (tmp1(i) * tmp1(i))  - (tmp2(i) * tmp2(i));
	}
	
	vol /= num;

	return vol;
}

arma::vec FixedHedgeRatios(const double beg = 0.0, const double end = 1.0, const double inc = 0.05)
{
	double value = beg;
	std::vector<double> htmp;
	
	do
	{
		htmp.push_back(value);
		value += inc;
	}
	while(value <= (end + inc));

	arma::vec hstar(htmp);
	
	return hstar;
}
	

int main()
{
	arma::mat data;
	data.load("gas-ret.csv", arma::csv_ascii);
	arma::vec hstar = FixedHedgeRatios();
	auto nrows = hstar.n_elem;

	const int B = 10000;
	arma::mat prf(nrows, B);
	arma::mat vol(nrows, B);
	arma::mat path;
	const double p = 0.1;

	
	for(auto i = 0; i < nrows; ++i)
	{
		for(auto b = 0; b < B; ++b)
		{
		    path = StationaryBootstrap(data, p);			
			prf(i, b) = ProfitLossFunction(path, hstar(i));
			vol(i, b) = VolatilityLossFunction(path, hstar(i));
		}
	}



	return 0;
}

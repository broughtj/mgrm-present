#include <cmath>
#include <iostream>
#include <random>
#include <vector>
#include <armadillo>


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
		

int main()
{
	arma::mat data;
	data.load("oil-ret.csv", arma::csv_ascii);
	//arma::vec hstar = arma::linspace<arma::vec>(0.0, 1.0, 0.01);
	//arma::vec hstar = arma::regspace<arma::vec>(0.0, 0.01, 1.0);
	//auto num = hstar.n_elem;
	//arma::vec loss = arma::vec(num);
	const int M = 21;
	arma::vec loss(M);
	arma::vec vol(M);
	arma::vec hstar(M);


	hstar(0) = 0.0;
	for(auto i = 1; i < M; ++i)
	{
		hstar(i) = hstar(i-1) + 0.05;
	}

	for(auto i = 0; i < M; ++i)
	{
		loss(i) = ProfitLossFunction(data, hstar(i));
		vol(i) = VolatilityLossFunction(data, hstar(i));
		//std::cout << hstar(i) << ", " << loss(i) << "," << vol(i) << std::endl;
	}

	loss.save("oil-historical.csv", arma::csv_ascii);
	

	return 0;
}






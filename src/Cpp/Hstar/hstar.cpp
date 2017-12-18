#include <armadillo>
#include <iostream>

int main()
{
	arma::vec hstar = arma::linspace<arma::vec>(0.0, 1.0, 0.05);
	std::cout << hstar << std::endl;

	return 0;
}


template<std::size_t SIZE>
void sample(std::array<double, SIZE>& arr, const int len)
{
	std::random_device rd;
	std::mt19937 g(rd());
	std::stuffle(arr.begin(), arr.end(), g);:wq



}


int main()
{
	


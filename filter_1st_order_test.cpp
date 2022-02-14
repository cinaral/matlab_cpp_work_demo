#include <iostream>
#include <string>
#include "filter_1st_order.h"
#include "matrix_io.h"

int 
main() 
{
	const std::string in_file   = "matrix_io_data/x_arr.dat";
	const std::string out_file  = "matrix_io_data/y_arr.dat";
	const std::string delimiter = ",";
	const double time_step      = 0.01;
	const double cutoff_freq    = 1;
	const matrix x_arr          = read_matrix(in_file, delimiter);
	static filter_1st_order filter{ time_step, cutoff_freq };
	
	std::cout << "t dim: " << x_arr.t_dim << std::endl;
	std::cout << "x dim: " << x_arr.x_dim << std::endl;

	matrix y_arr = filter.test(x_arr);

	write_matrix(y_arr, out_file, delimiter);
	return 0;
}
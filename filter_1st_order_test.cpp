#include <iostream>
#include <string>
#include "matrix_io.h"

#include "filter_1st_order.h"
static filter_1st_order filter;

//* for codegen comparsion
//#include "fn_1st_order_filter.h"	
//#include "parameters.h"

const std::string in_file   = "matrix_io_data/x_arr.dat";
const std::string out_file  = "matrix_io_data/y_arr.dat";
const std::string delimiter = ",";

int 
main() {
	const matrix x_arr = read_matrix(in_file, delimiter);
	std::cout << "t dim: " << x_arr.t_dim << std::endl;
	std::cout << "x dim: " << x_arr.x_dim << std::endl;

	matrix y_arr = filter.test(x_arr);
	//* for codegen comparison
	//using namespace parameters;
	//matrix y_arr = x_arr;
	//for (int i = 0; i < x_arr.t_dim; i++) {
	//	y_arr.val[i] = fn_1st_order_filter(x_arr.val[i], time_step, cutoff_freq);
	//}

	write_matrix(y_arr, out_file, delimiter);
	return 0;
}
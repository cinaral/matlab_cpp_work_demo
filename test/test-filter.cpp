#include <iostream>
#include <string>

#include "MatrixIO.hpp"
#include "Filter1stOrder.hpp"

static Filter1stOrder filter;

const std::string data_dname  = "../../dat";
const std::string x_arr_fname = "x_arr.dat";
const std::string y_arr_fname = "y_arr.dat";
const std::string delimiter   = ",";

int main() {
	const matrix x_arr = read_matrix(data_dname + "/" + x_arr_fname, delimiter);
	matrix y_arr       = x_arr;

	for (int i = 0; i < x_arr.t_dim; i++) {
		y_arr.val[i] = filter.filter(x_arr.val[i]);
	}

	write_matrix(y_arr, data_dname + "/" + y_arr_fname, delimiter);

	return 0;
}
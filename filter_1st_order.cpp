#include "filter_1st_order.h"

using namespace parameters;

double 
filter_1st_order::filter(double x_0)
{
	double y_0 = ((time_step*x_0 + time_step*x_1_) - (time_step - 2*time_const)*y_1_)/(time_step + 2*time_const);
	x_1_       = x_0;
	y_1_       = y_0;
	return y_0;
}

matrix
filter_1st_order::test(matrix x_arr)
{
	matrix y_arr  = x_arr;

	for (int i = 0; i < x_arr.t_dim; i++) {
		y_arr.val[i] = filter_1st_order::filter(x_arr.val[i]);
	}

	return y_arr;
}

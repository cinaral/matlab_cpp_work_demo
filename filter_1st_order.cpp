#include "filter_1st_order.h"

filter_1st_order::filter_1st_order(double time_step, double cutoff_freq)
{
	time_step_ = time_step;
	tau_       = 1/(2*PI*cutoff_freq);
}

double 
filter_1st_order::filter(double x_0)
{
	double y_0 = ((time_step_*x_0 + time_step_*x_1_) - (time_step_ - 2*tau_)*y_1_)/(time_step_ + 2*tau_);
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

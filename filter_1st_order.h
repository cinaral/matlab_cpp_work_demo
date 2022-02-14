#ifndef FILTER_1ST_ORDER_H_CINARAL_220213_1456
#define FILTER_1ST_ORDER_H_CINARAL_220213_1456

#include "matrix_io.h"

#define PI 3.14159265358979323846

class filter_1st_order 
{
	private:
		double time_step_;
		double cutoff_freq_;
		double tau_;
		double y_1_ = 0.0;
		double x_1_ = 0.0;

	public:
		filter_1st_order(double, double);

		double filter(double);
		matrix test(matrix);
};

#endif
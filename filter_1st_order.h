#ifndef FILTER_1ST_ORDER_H_CINARAL_220213_1456
#define FILTER_1ST_ORDER_H_CINARAL_220213_1456

#include "matrix_io.h"
#include "parameters.h"

class filter_1st_order 
{
	private:
		double y_1_ = 0.0;
		double x_1_ = 0.0;

	public:
		double filter(double);
		matrix test(matrix);
};

#endif
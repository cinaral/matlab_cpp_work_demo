#ifndef FILTER1STORDER_HPP_CINARAL_220213_1456
#define FILTER1STORDER_HPP_CINARAL_220213_1456

#include "MatrixIO.hpp"
#include "Parameters.hpp"

class Filter1stOrder 
{
	private:
		double y_1_ = 0.0;
		double x_1_ = 0.0;

	public:
		double filter(double);
		matrix test(matrix);
};

#endif
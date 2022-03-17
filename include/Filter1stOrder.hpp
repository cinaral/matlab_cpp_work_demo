#ifndef FILTER1STORDER_HPP_CINARAL_220213_1456
#define FILTER1STORDER_HPP_CINARAL_220213_1456

#include "Parameters.hpp"

class Filter1stOrder 
{
	private:
		float y_prev_ = 0.F;
		float x_prev_ = 0.F;

	public:
		float filter(float x);
};

#endif
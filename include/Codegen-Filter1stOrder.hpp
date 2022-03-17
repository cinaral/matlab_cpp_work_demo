#ifndef CODEGEN_FILTER1STORDER_HPP_CINARAL_220317_1312
#define CODEGEN_FILTER1STORDER_HPP_CINARAL_220317_1312

#include "Parameters.hpp"
#include "filter_1st_order.h"

class Filter1stOrder 
{
	private:
		float y_prev_ = 0.F;
		float x_prev_ = 0.F;

	public:
		float filter(float x);
};

#endif
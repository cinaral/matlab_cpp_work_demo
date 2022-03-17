#include "Codegen-Filter1stOrder.hpp"

using namespace Parameters;

float
Filter1stOrder::filter(float x)
{
	float y = filter_1st_order(y_prev_, x, x_prev_, time_step, time_const);
	x_prev_  = x;
	y_prev_  = y;
	return y;
}

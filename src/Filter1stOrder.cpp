#include "Filter1stOrder.hpp"

using namespace Parameters;

float
Filter1stOrder::filter(float x)
{
	float y = ((time_step*x + time_step*x_prev_) - (time_step - 2*time_const)*y_prev_)/(time_step + 2*time_const);
	x_prev_  = x;
	y_prev_  = y;
	return y;
}

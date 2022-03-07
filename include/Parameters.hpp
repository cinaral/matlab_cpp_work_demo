#ifndef PARAMETERS_HPP_CINARAL_220216_1525
#define PARAMETERS_HPP_CINARAL_220216_1525

namespace Parameters
{
	constexpr float pi          = 3.14159265358979323846;
	constexpr float time_step   = 0.01;
	constexpr float cutoff_freq = 1;
	constexpr float time_const  = 1/(2*pi*cutoff_freq);
}

#endif
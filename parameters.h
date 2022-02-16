#ifndef PARAMETERS_H_CINARAL_220216_1525
#define PARAMETERS_H_CINARAL_220216_1525

namespace parameters
{
	constexpr double pi = 3.14159265358979323846;
	constexpr double time_step   = 0.01;
	constexpr double cutoff_freq = 1;
	constexpr double time_const  = 1/(2*pi*cutoff_freq);
}

#endif
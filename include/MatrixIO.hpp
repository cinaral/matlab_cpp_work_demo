#ifndef MATRIXIO_H_CINARAL_2022_02_02_1843
#define MATRIXIO_H_CINARAL_2022_02_02_1843

#include <iostream>
#include <fstream>
#include <vector>
#include <iomanip>
#include <limits>

struct matrix
{
	//* [t_dim, x_dim] matrix
	std::vector<float> val;
	int t_dim;
	int x_dim;
};

matrix read_matrix(const std::string, const std::string);

void write_matrix(matrix, const std::string, const std::string);

#endif
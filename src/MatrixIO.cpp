#include "MatrixIO.hpp"

//* read matrix from file separated by newlines and delimiter
//* t_dim = number of rows
//* x_dim = number of columns 
matrix read_matrix(const std::string file_name, const std::string delimiter)
{
	//* input file stream
	std::ifstream in_file;
	in_file.open(file_name);
	matrix mat;

	if (in_file.is_open()) {
		std::string line;
		std::string entry;
		int t_dim          = 0;
		int x_dim          = 0;
		bool is_first_line = true;
		size_t str_pos     = 0;

		while (std::getline(in_file, line)) {
			entry = line.substr(0, line.find(delimiter));

			//* parse the line by splitting at the delimiters
			while ((str_pos = line.find(delimiter)) != std::string::npos) {
				entry = line.substr(0, str_pos);
				line.erase(0, str_pos + delimiter.length());
				mat.val.push_back(std::stod(entry));

				//* count the x dimension once
				if (is_first_line) {
					x_dim++;
				}
			}
			//* last entry before the line break
			mat.val.push_back(std::stof(line));
			
			//* count the t dimension
			t_dim++;
			is_first_line = false;
		}
		
		mat.t_dim   = t_dim;
		mat.x_dim   = x_dim + 1;
	}
	else {
		std::cout << "Could not open the input file " << file_name << std::endl;
	}
	in_file.close();

	return mat;
}

//* write matrix to file separated by newlines and delimiter
//* t_dim = number of rows
//* x_dim = number of columns 
void write_matrix(matrix mat, const std::string file_name, const std::string delimiter)
{
	const uint32_t print_precision = std::numeric_limits<float>::digits10 + 1;

	//* output file stream	
	std::ofstream out_file;
	out_file.open(file_name);

	if (out_file.is_open()) {

		for (int i = 0; i < mat.t_dim; i++) {

			for (int j = 0; j < mat.x_dim; j++) {
				out_file << std::setprecision(print_precision) << mat.val[i*mat.x_dim + j];

				if (j < mat.x_dim - 1) {
					out_file << delimiter;
				}
			}

			if (i < mat.t_dim) {
				out_file << std::endl;
			}
		}
	}
	else {
		std::cout << "Could not open the output file " << file_name << std::endl;
	}
	out_file.close();
}
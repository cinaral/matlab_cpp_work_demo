#include <fstream>
#include <string>
#include "Parameters.hpp"
#include <iomanip>
#include <limits>

using namespace Parameters;

const std::string parameters_dname = "param";
const std::string scalars_fname    = parameters_dname + "/" + "Scalars";
const std::string delimiter        = ",";

const uint32_t print_precision = std::numeric_limits<float>::digits10 + 1;

int main()
{	
	std::ofstream scalars_file;
	scalars_file.open(scalars_fname);
	
	scalars_file << std::setprecision(print_precision) << "time_step "   << time_step   << std::endl;
	scalars_file << std::setprecision(print_precision) << "cutoff_freq " << cutoff_freq << std::endl;
	scalars_file << std::setprecision(print_precision) << "time_const "  << time_const;

	scalars_file.close();

	return 0;
}
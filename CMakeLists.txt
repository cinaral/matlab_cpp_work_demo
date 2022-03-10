#****************************************#
#* Cmake, language and compiler options *#
#****************************************#
cmake_minimum_required(VERSION 3.13)
set(CMAKE_C_COMPILER            "gcc")
set(CMAKE_CXX_COMPILER          "g++")
set(CMAKE_CXX_STANDARD          17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

add_compile_options(
	-fdiagnostics-color=always 
	-fmessage-length=0
	#-fmax-errors=5 #* max number of warnings
	-fno-rtti #* disable RTTI 
	-fno-exceptions #* disable exceptions
	-fno-non-call-exceptions 
	-fno-use-cxa-atexit #* disable destructors
	-fno-common #* declare globals once
	-ffreestanding #* standard library may be unavailable
	#-fstack-protector-strong #* stack guard, costs one write and read per function, needs canary
	-Wall #* all warnings
	-Wextra
	-Wpedantic
	#-Wno-unused-variable
	#-Wno-unused-parameter
	#-Wno-unused-but-set-parameter
)

#* force debug mode in case CMAKE_BUILD_TYPE was not set
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING
            "Default build type: Debug" FORCE)
endif()

#* set up directories for binary, library, data and parameter files 
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
file(MAKE_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/dat)
file(MAKE_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/param)

#* where to look for the project header and source files
set(INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/include)
set(SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/src)

#* set the number of CPUs 
include(ProcessorCount)
ProcessorCount(N)

if(NOT N EQUAL 0)
	set(CTEST_BUILD_FLAGS -j${N})
	set(ctest_test_args ${ctest_test_args} PARALLEL_LEVEL ${N})
endif()
message("> Number of cores set to ${N}")


#***********#
#* Project *#
#***********#
project(OG_OC VERSION 0.1.0 LANGUAGES CXX)

#* build Filter1stOrder 
add_library(Filter1stOrder STATIC 
	        ${SRC_DIR}/Filter1stOrder.cpp 
	        ${SRC_DIR}/MatrixIO.cpp)

target_include_directories(Filter1stOrder
    PUBLIC 
		${INCLUDE_DIR}	
)

#* build ParametersToFile.hpp
add_executable(ParametersToFile ${SRC_DIR}/ParametersToFile.cpp)

target_include_directories(ParametersToFile
    PUBLIC 
		${INCLUDE_DIR}	
)

#* call ParametersToFile.exe after build
add_custom_command(
	TARGET ParametersToFile
	POST_BUILD
	COMMAND ParametersToFile
	WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
)

				   
#***********#
#* Testing *#
#***********#
enable_testing()

#* add or remove tests
set(TEST_NAMES
	test_filter
)

#* loops through all tests
foreach(ELEMENT ${TEST_NAMES})
	add_executable(${ELEMENT} test/${ELEMENT}.cpp)
	target_link_libraries(${ELEMENT} Filter1stOrder)
	add_test(NAME              ${ELEMENT} 
		     COMMAND           ${ELEMENT}
		     WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
endforeach(ELEMENT ${TEST_NAMES})
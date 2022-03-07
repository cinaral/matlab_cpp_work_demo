#****************************************#
#* Cmake, language and compiler options *#
#****************************************#
cmake_minimum_required(VERSION 3.9)
set(CMAKE_C_COMPILER            "gcc")
set(CMAKE_CXX_COMPILER          "g++")
set(CMAKE_CXX_STANDARD          14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

add_compile_options(-fdiagnostics-color=always 
	            	-fmessage-length=0
	            	-Wall #* all warnings
	            	-Wextra
	            	-Wpedantic
	            	-Wno-unused-parameter
	            	-Wno-unused-variable
	            	-Wno-unused-but-set-parameter
	            	-fmax-errors=5 #* max number of warnings
	            	#-fno-rtti #* disable RTTI 
	            	#-fno-exceptions #* disable exceptions
	            	#-fno-non-call-exceptions 
	            	#-fno-use-cxa-atexit #* disable destructors
	            	#-fno-common #* declare globals once
	            	#-ffreestanding #* standard library may be unavailable
	            	#-fstack-protector-strong #* stack guard, costs one write and read per function, needs canary
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


#***********#
#* Project *#
#***********#
project(ExampleProject VERSION 1.0.0 LANGUAGES CXX)

#* where to look for header and source files
include_directories(${PROJECT_SOURCE_DIR}/include)
set(SRC_DIR ${PROJECT_SOURCE_DIR}/src)

add_library(Filter1stOrder STATIC 
	        ${SRC_DIR}/Filter1stOrder.cpp 
	        ${SRC_DIR}/MatrixIO.cpp)

#* print Parameters.hpp to file after build
add_executable(ParametersToFile 
	           ${PROJECT_SOURCE_DIR}/src/ParametersToFile.cpp)

add_custom_command(TARGET ParametersToFile
				   POST_BUILD
				   COMMAND ParametersToFile
				   WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

				   
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
	add_executable(${ELEMENT} tests/${ELEMENT}.cpp)
	target_link_libraries(${ELEMENT} Filter1stOrder)
	add_test(NAME              ${ELEMENT} 
		     COMMAND           ${ELEMENT}
		     WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
endforeach(ELEMENT ${TEST_NAMES})
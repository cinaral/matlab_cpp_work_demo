#****************************************#
#* Cmake, language and compiler options *#
#****************************************#

#* cmake and compiler requirements
cmake_minimum_required( VERSION 3.13 )
set( CMAKE_C_COMPILER            "gcc" )
set( CMAKE_CXX_COMPILER          "g++" )
set( CMAKE_CXX_STANDARD          17 )
set( CMAKE_CXX_STANDARD_REQUIRED ON )
set( CMAKE_CXX_EXTENSIONS        OFF )

#* set global compile options
#* use target_compile_options() for target compile options
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
	#-Wno-unused-variable
	#-Wno-unused-parameter
	#-Wno-unused-but-set-parameter
	-Wall #* all warnings
	-Wextra
	-Wpedantic )

#* force debug mode in case CMAKE_BUILD_TYPE was not set
if( NOT CMAKE_BUILD_TYPE )
    set( CMAKE_BUILD_TYPE "Debug" CACHE STRING
            "Default build type: Debug" FORCE )
endif()

#* set up directories for binary, library, data and parameter files 
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )
set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
file( MAKE_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/param )
file( MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/dat )

#* where to look for the project header and source files
set( INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/include )
set( SRC_DIR ${CMAKE_CURRENT_LIST_DIR}/src )

option( IS_USING_CODEGEN "Use MATLAB codegen generated code" ON )

if(IS_USING_CODEGEN)
	set(CODEGEN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/matlab/codegen )
endif(IS_USING_CODEGEN)

#* set the number of CPUs 
include( ProcessorCount )
ProcessorCount( N )

if( NOT N EQUAL 0 )
	set( CTEST_BUILD_FLAGS -j${N} )
	set( ctest_test_args ${ctest_test_args} PARALLEL_LEVEL ${N} )
endif()
message( "> Number of cores set to ${N}" )


#***********#
#* Project *#
#***********#
project( OG_OC VERSION 0.1.0 LANGUAGES CXX )

#* build Filter1stOrder 
if( IS_USING_CODEGEN )

	if( NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/matlab/codegen/filter_1st_order.cpp )
		 message( FATAL_ERROR "> filter_1st_order.cpp has not been generated, please run matlab/codegen__filter_1st_order first" )
	endif( NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/matlab/codegen/filter_1st_order.cpp )

	add_library( Filter1stOrder STATIC 
		${SRC_DIR}/Codegen-Filter1stOrder.cpp
		${SRC_DIR}/MatrixIO.cpp 
		${CODEGEN_DIR}/filter_1st_order.cpp )

	target_include_directories( Filter1stOrder
		PUBLIC 
			${INCLUDE_DIR}	
			${CODEGEN_DIR} )
else()
	add_library( Filter1stOrder STATIC 
		${SRC_DIR}/Filter1stOrder.cpp 
		${SRC_DIR}/MatrixIO.cpp )

	target_include_directories( Filter1stOrder
		PUBLIC 
			${INCLUDE_DIR} )
endif( IS_USING_CODEGEN )

#* build ParametersToFile.hpp
add_executable( ParametersToFile ${SRC_DIR}/ParametersToFile.cpp )

target_include_directories( ParametersToFile
    PUBLIC 
		${INCLUDE_DIR} )

#* call ParametersToFile.exe after build
add_custom_command(
	TARGET ParametersToFile
	POST_BUILD
	COMMAND ParametersToFile
	WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} )
				   
#***********#
#* Testing *#
#***********#
enable_testing()

#* add or remove tests
set( TEST_NAMES
	test-filter )

#* loops through all tests
foreach( ELEMENT ${TEST_NAMES} )
	add_executable( ${ELEMENT} test/${ELEMENT}.cpp )
	target_link_libraries( ${ELEMENT} Filter1stOrder )
	add_test( NAME              ${ELEMENT} 
		     COMMAND           ${ELEMENT}
		     WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} )
endforeach( ELEMENT ${TEST_NAMES} )
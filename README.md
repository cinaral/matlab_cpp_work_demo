# **MATLAB and C/C++ Combined Workflow Demonstration** 

## **What is this?**

This is an example project about prototyping and verifying C/C++ code using MATLAB.

- [MATLAB](https://www.mathworks.com/products/matlab.html) is a programming and numeric computing platform with powerful data analysis and graphics tools.
- C is a general-purpose, procedural programming language with little hardware abstraction. It is efficient, portable and commonly used in embedded systems.
- [C++](https://isocpp.org/get-started) is almost a superset of C. It is one of the highest-level programming languages that can still provide deterministic execution time.

## **Quick start**

### a) Prerequisites:
1. [CMake](https://cmake.org/)
2. A C/C++ compiler, e.g. [MinGW-w64 for Windows](https://www.mingw-w64.org/)
3. [MATLAB](https://www.mathworks.com/products/matlab.html)

### **b) Creating a new project:**
	
1. Set up your project directory as shown
   
	``` 
	<Project Name>
	├─📂docs
	├─📂include
	├─📂matlab
	├─📂src
	├─📂tests
	│ └─📂matlab
	│	└─ run_all_tests.m
	├─ CMakeLists.txt
	└─ README.md
	```
	| File/Folder                                       | Explanation |
	| -                                                 | - |
	| /docs                                             | Documentation files (.md, .docx, .txt...) |
	| /include                                          | Header files (.h, .hpp, .hxx, ...)   |
	| /matlab                                           | MATLAB scripts, prototypes, derivations (.m, .slx, ...)   |
	| /src                                              | Source files (.c, .cpp, .cxx, ...)   |
	| /tests                                            | Test files (.c, .cpp, .cxx, ...)   |
	| /tests/matlab                                     | MATLAB test scripts (.m, ...)   |
	| [run_all_tests.m](./tests/matlab/run_all_tests.m) | MATLAB script to call all MATLAB test scripts |
	| [CMakeLists.txt](CMakeLists.txt)                  | Describes the build process, read by CMake |
	| [README.md](README.md)                            | Summary of the project |

2. Start with your mathematical derivations and document them in  ```/docs```, e.g. [derivation.ipynb](./docs/derivation.ipynb). 
3. Prototype your derivations in MATLAB in ```/matlab```, e.g. [filter_1st_order.m](./matlab/filter_1st_order.m).
4. Write MATLAB test scripts for your prototypes in ```/tests/matlab``` to verify them.
5. Code your project based on the prototypes, this step may include C/C++ code generation from MATLAB code. Do whichever is appropriate and convenient. Problem parameters known at compile time should be written in a separate header file, e.g. [Parameters.hpp](./include/Parameters.hpp).
6. Write your unit tests in ```/tests```. These unit tests should be automated as much as possible, but for verification and debug purposes a human may need to look at some plots. For this task read/write data to disk, and plot the data using MATLAB. It is important to share the problem parameters with the MATLAB test scripts. This can be achieved by including a step in the build instructions to write them to simple MATLAB-readable files, e.g. [ParametersToFile.cpp](./src/ParametersToFile.cpp).
7. Update the MATLAB test scripts to incorporate the unit tests if desired, e.g. [test_filter.m](./tests/matlab/test_filter.m). 

### **c) Building and verifying an existing project:**
1. Configure the project using CMake.
2. Build the project and run CTest tests.
3. Run the MATLAB script ```run_all_tests.m```.
   
For help, see the [How to compile?](#how-to-compile) section.

## **Main principles**

1. Prototype in MATLAB
2. Code and implement in C/C++
3. Verify in MATLAB

Unit testing is highly encouraged. [Here](https://www.boost.org/doc/libs/1_36_0/libs/test/doc/html/tutorials/intro-in-testing.html) is a good introduction to unit testing. The tester may or may not be the original programmer or a programmer.


## **Workflow**

```
   MATLAB
   ┌──────────────────────┐
   │ 1)                   │
   │ ┌─────────┐          │
   │ │Prototype│◄────┐    │
   │ └────┬────┘     │    │
   │      │       ┌──┴──┐ │
   │      │       │Debug│ │
   │      ▼       └──┬──┘ │   
   │  ┌───────┐      │    │
┌──┼─►│Verify ├──────┘    │
│  │  └───────┘           │
│  └──────────────────────┘
│                    
│  C/C++             
│  ┌──────────────────────┐
│  │    2)                │
│  │    ┌─────┐           │
│  │    │Write│◄────┐     │
│  │    └──┬──┘  ┌──┴──┐  │
│  │       │     │Debug│  │
│  │       ▼     └──┬──┘  │
│  │   ┌───────┐    │     │
├──┼───┤Compile│────┘     │
│  │   └───┬───┘          │
│  └───────┼──────────────┘
│          │
│  Embedded│system
│  ┌───────┼──────────────┐
│  │  3)   ▼              │
│  │  ┌──────────┐        │
└──┼──┤Experiment│        │
   │  └──────────┘        │
   └──────────────────────┘
```

The workflow is split into three environments,
1. MATLAB
2. C/C++: Editor/IDE and build tools
3. Embedded system: Microcontroller

These environments have different levels of flexibility and portability. The main objective of this workflow is to play the strengths of each environment. MATLAB is very powerful for prototyping algorithms and verifying data, and so all verification should take place in MATLAB. 

Verification means different things during different stages of development (i) In the prototyping stage it means prototypes are compared against existing data and solutions (e.g. analytical solutions), and (ii) in the coding and implementation stage it means the results produced meet expectations. You should worry about ideas while sketching and worry about the technique when drawing. 


Verifying results from C/C++ and the embedded system in MATLAB is *not* a substitute for unit testing in their respective environments. All three environments should have their own (automated) unit testing routines whenever possible, including MATLAB prototypes. The MATLAB prototype can guide unit testing in other environments. 


## **How to compile?**

You will need a C++ compiler to compile ```.cpp``` files. You can use [VS Code with gcc](https://code.visualstudio.com/docs/languages/cpp) for this task. 

You could also use [VS Code with CMake Tools](https://code.visualstudio.com/docs/cpp/cmake-linux) if you have Bash. [MSYS2](https://www.msys2.org/) is a good way to get Bash VS Code on Windows. [CMake](https://cmake.org/) is an automated cross-platform build system generator.

## **Extensions**

Once the C/C++ code is verified, it can easily be integrated to any environments. For example, it can be wrapped in Python for easy installation and visualization, such as graphical user interfaces. This can potentially extend our verification capabilities by allowing easy communication between different devices over different protocols.


## **Potential gotcha's**

- The prototype and the C/C++ implementation may diverge over time. If this happens, since the C/C++ implementation must be verified, this may necessitate updating the prototype or adding new MATLAB code for comparison purposes. 
- MATLAB may not be available everywhere. Whenever possible the unit tests should work independently of the MATLAB testing scripts.
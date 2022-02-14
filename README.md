# **MATLAB and C/C++ Combined Workflow Demonstration** 
### 2022-02-12


## **What is this?**

This is an example project about prototyping and verifying C/C++ code using MATLAB.

[MATLAB](https://www.mathworks.com/products/matlab.html) is a programming and numeric computing platform with powerful data analysis and graphics tools. It has built-in functions for many methods taught in the engineering curriculum, and it is familiar to many engineers, scientists and students.

C is a general-purpose, procedural programming language with little hardware abstraction. It is efficient and portable, so it is commonly used in embedded systems.

[C++](https://isocpp.org/get-started) is an extension and a superset of C with a few exceptions. It supports object-oriented, generic, and functional programming features which can help writing readable and maintainable code. For real-time systems C++ is one of the highest-level programming languages that can still provide deterministic execution time.


## **Main principles**

1. Prototype in MATLAB
2. Code and implement in C/C++
3. Verify in MATLAB

It is encouraged to adopt unit testing and this testing should be done automatically whenever possible. [Here](https://www.boost.org/doc/libs/1_36_0/libs/test/doc/html/tutorials/intro-in-testing.html) is a good introduction to unit testing. The tester may or may not be the original programmer or a programmer.


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

These environments have different levels of flexibility and portability. The main objective of this workflow is to play the strength of each environment. MATLAB is very powerful for prototyping algorithms and verifying data, and so all verification should take place in MATLAB. 

Verification means different things during different stages of development (i) In the prototyping stage it means prototypes are compared against existing data and solutions (e.g. analytical solutions), and (ii) in the code writing and implementation stage it means the results produced meet design expectations. You should worry about ideas while sketching and worry about the technique when drawing. 

Debugging in the prototyping stage means new ideas are tested, and in the C/C++ stage debugging means the code runs as expected on the target hardware.

Verifying results from C/C++ and the embedded system in MATLAB is *not* a substitute for unit testing in their respective environments. All three environments should have their own (automated) unit testing routines whenever possible, including MATLAB prototypes. The MATLAB prototype can guide unit testing in other environments. 


## **Example**
For the derivation see [here](derivation.ipynb).

We implement a first order-filter on a microcontroller in the following steps:

1. Write ```main.m```, this MATLAB script will serve as the entry point to our project. This file checks if the compiled test function exists and then calls the test script.
2. Prototype the first order filter in discrete time in ```filter_1st_order.m```. 
3. Test the prototype using the ```filter_1st_order_test.m``` script. This testing script also serves as an implementation example for the prototype. We verify the prototype by comparing the results to the known solution of 1st order response to a sine wave.
4. Once satisfied with the prototype, write ```filter_1st_order.cpp``` based on the prototype.
5. Also write ```filter_1st_order_test.cpp```based on the test script for the prototype, so that it is the same test. This test program also serves as an implementation example for the code.
6. Compile the test and include it in the MATLAB test script.

## **How to compile?**

You will need a C++ compiler to compile ```.cpp``` files. You can use [VS Code with gcc](https://code.visualstudio.com/docs/languages/cpp) for this task. 

You could also use [VS Code with CMake Tools](https://code.visualstudio.com/docs/cpp/cmake-linux) if you have Bash. [MSYS2](https://www.msys2.org/) is a good way to get Bash VS Code on Windows. [CMake](https://cmake.org/) is an automated cross-platform building system.

## **Extensions**

Once the C/C++ code is verified, it can easily be integrated with new environments other than the embedded system. For example, it can be wrapped in Python for easy installation and visualization, such as graphical user interfaces. This can potentially extend our verification capabilities by allowing easy communication between different devices over different protocols.


## **Potential downsides**

- The prototype and the C/C++ implementation may diverge over time. If this happens, since the C/C++ implementation must be verified, this may necessisate updating the prototype or adding new MATLAB code for comparison purposes. 
- It may be difficult to write some mathematical abstractions in C/C++ by hand, for example when Symbolic Toolbox is used to obtain the dynamics of a complex system. In this case, some units should be generated and implemented using appropriate wrapper functions.

- MATLAB may not be available everywhere and every time someone wants to verify the C/C++ code. Additionally, whenever possible C/C++ code should have their own testing functions, and these tests should be part of the CMake routine.

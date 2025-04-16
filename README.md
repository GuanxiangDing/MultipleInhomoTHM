## A Semi-Analytical Method for Thermal Field Analysis of Multiple Arbitrarily Shaped Inhomogeneities in Heterogeneous Geological Media

This code simulates multiple arbitrarily shaped inhomogeneities in a heterogeneous geologic media and computes the thermal field solutions under a remote heat flux, encompassing temperature, temperature gradient and heat flux. Furthermore, it evaluates the effect of the presence of inhomogeneities on the thermal field and the interactions between the multiple inhomogeneities.

## Main components of the program and their respective functions
(1) INPUT.DAT: This file sets the basic parameters for the input program, such as shape, geometric length and the distribution of the inhomogeneities, the number of iterations, and the size of the matrix.
(2) PROGMAIN.F90: This module calls the data from INPUT.DAT and executes various subprograms based on the parameters specified in that file.
(3) GRIDMESH.F90: This module determines the size of the computational domain and performs grid partitioning, discretizing the computational area into rectangular elements. It also sets the basic dimensions and corresponding coordinates of these rectangular elements.
(4) ITEGNFLD.F90: This module determines whether a rectangular element is located within an inhomogeneity and specifies the output format for the calculated data, as well as the parameters for the target line.
(5) ITMAXEGN.F90: This module performs a convergence error judgment on the control equations in Equivalent Inclusion Method (EIM).
(6) TEMP.f90: This module corresponds to the disturbed temperature solutions. It calls the ZEROP2DB function for zero-completion operation, the ICFFTCNV function to perform wrap-around operation and construct the circulant matrix, and the CNVFT2CB function to carry out the convolution operation for transforming from the frequency domain back to the time domain. 
(7) TEMPGRAD.f90 and HEATFLOW.f90: These modules correspond to the disturbed temperature gradient solutions and disturbed heat flux solutions, respectively. They utilize functions similar like those in point (5).
(8) TEMP-FUNCTION.f90, TEMPGRAD-FUNCTION.f90 and HEATFOLW-FUNCTION.f90: These modules represent the solutions for temperature, temperature gradient and heat flux, respectively.
(9) FFT2DSub.f90 and FFTW.f90: These modules are the Fast Fourier Transform algorithm.
This code was developed and tested in a fortran environment and oneAPI.

## Steps
(1) Set the basic parameters in INPUT.DAT.
(2) Set the number of discrete grids in GRIDMESH.F90.
(3) Set the target line of the output data in ITEGNFLD.F90. 
(4) Run the program.
(5) Get the data in the corresponding output file.
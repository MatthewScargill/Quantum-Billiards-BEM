# Boundary Element Method for Quantum Billiards

Spectrum solver for 2D Helmholtz quantum billiard problems with Dirichlet boundary conditions. Implements a Boundary Element Method (BEM) to construct boundary data, assemble boundary integral operators, and scan wavenumbers to approximate resonant modes. Includes wavefunction visualisation and spectral analysis tools. 

This is a refined version of code originally developed for my master's project (text found in rsc/). It's still a good companion to this repo as it provides added context and the methods are identical. 

## Overview
Quantum billiards describe particles confined in a 2D region with perfectly reflecting walls. Solving the Helmholtz equation under Dirichlet boundary conditions
$$(\nabla^2 + k^2)\psi = 0, \quad \psi|_{\partial \Omega} = 0$$
gives rise to resonant eigenfrequencies $k_i$ which correspond to the energy spectrum of the system ($E_i=k_i^2$).
This project applies a Nyström-based **Boundary Element Method (BEM)** to convert this into a **Boundary Integral Equation** using the free-space Green’s function
$$G_{k}(\mathbf{r}, \mathbf{r'}) = \frac{i}{4} H_{0}^{(1)}(k|\mathbf{r}- \mathbf{r'}|).$$
This leads to an matrix equation of the form ($A\psi = 0$), to which solutions are deduced by scanning across a range of $k$ and detecting singularities in the boundary operator $A$ via **SVD minima**. Evaluating this equation at such resonant modes allows us to evaluate realistic wavefunctions and plot them on the billiard.

Analysing the spectra of billiards 

![example billiard](rsc/img/example_billiard.svg)


Analysing the spectra of such billiards also 


This project currently supports the following geometries:
- Circle
- Square and rectangular billiards (classically regular)
- Cardioid billiard (classically chaotic)
- Bunimovich stadium billiard

## Features

- ✅ Boundary Element discretisation of the 2D Helmholtz equation  
- ✅ Automatic assembly of the BEM matrix using Green’s functions  
- ✅ Resonance detection via singular value analysis  
- ✅ Visualisation of wavefunctions inside the billiard  
- ✅ Spectrum unfolding using Weyl’s law  
- ✅ Spacing distribution and spectral statistics analysis  


## Quickstart example

(maybe merge the above 2)


## Structure

## installation

this clones the repo 

```
git clone https://github.com/MatthewScargill/QuantumBilliards.jl.git
```
opens the project

```
cd QuantumBilliards.jl 
```

then run this in the julia repl to deal with dependencies




```
using Pkg; Pkg.activate("."); Pkg.instantiate()
```

now just bash out one of these badboys 


```
using QuantumBilliards
```

-----

Contributions, extensions, or research discussions are welcome.
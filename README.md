# Boundary Element Method for Quantum Billiards

Spectrum solver for 2D Helmholtz quantum billiard problems with Dirichlet boundary conditions. Implements a Boundary Element Method (BEM) to construct boundary data, assemble boundary integral operators, and scan wavenumbers to approximate resonant modes. Includes wavefunction visualisation and spectral analysis tools. 

This is a refined version of code originally developed for my master's project (text found in rsc/). It's still a good companion to this repo as the methods are identical and it provides physical context.

## Overview
Quantum billiards describe particles confined in a 2D region with perfectly reflecting walls. Solving the Helmholtz equation under Dirichlet boundary conditions
```math
(\nabla^2 + k^2)\psi = 0, \quad \psi|_{\partial \Omega} = 0
```
gives rise to resonant eigenfrequencies $k_i$ which correspond to the energy spectrum of the system ($E_i=k_i^2$).
This project applies a Nyström-based **Boundary Element Method (BEM)** to convert this equation into a **Boundary Integral Equation** using the free-space Green’s function
```math
G_{k}(\mathbf{r}, \mathbf{r'}) = \frac{i}{4} H_{0}^{(1)}(k|\mathbf{r}- \mathbf{r'}|).
```
This leads to an matrix formulation of the form ($A\psi = 0$), to which solutions are deduced by scanning across a range of $k$ and detecting singularities in the boundary operator $A$ via **SVD minima**. Evaluating at individual resonant modes allows us to reconstruct physically relevant wavefunction solutions on the billiard as seen below. More generally, evaluating the spacing (Wigner-Dyson) statistics of the spectra of billiard systems allow us to draw parallels between classical and quantum notions of chaos. This project is equipped with the tools for all of the above, along with my thesis which acts as a more comprehensive manual for the theory.

## Features

- ✅ Boundary Element discretisation of the 2D Helmholtz equation  
- ✅ Automatic assembly of the BEM matrix using Green’s functions  
- ✅ Resonance detection via singular value analysis  
- ✅ Visualisation of wavefunctions inside the billiard  
- ✅ Spectrum unfolding using Weyl’s law  
- ✅ Spacing distribution and spectral statistics analysis  
- ✅ Support for circle, square, rectangle, cardioid, and Bunimovitch stadium geometries


## Quickstart example

(maybe merge the above 2)

![example billiard](rsc/img/example_billiard.svg)



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
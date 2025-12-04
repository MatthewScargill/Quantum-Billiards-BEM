# Example Workflow

Firstly, we must initialise our billiards boundary data using a _info function. This module comes preloaded with cardioid_info, circle_info, rectangle_info, square_info, and stadium_info. 

```julia
using QuantumBilliards

N = 700 # initialise the number of nodes along the billiard boundary 

# all _info function can simply take in N, but can also take dimension information 
xs, ns, w, geom_data = QuantumBilliards.cardioid_info(N) # here the cardioid is chosen as an example
```
Here, "xs" and "ns" are arrays (length N) of vectors (length 2) which define the boundary points and their normals. "w" is an array (length N) of weights associated to each of the nodes defined in "xs" (both currently uniform, with more advanced quadrature schemes to be added). "geom_data" is a tuple defining first the area and then the perimeter of the billiard (for Weyl counting function prediction and unfolding process). To easily sanity check any billiards you may want to add, you may want to run the following function to produce a graph of the joint billiards and their associated normals (must obviously follow the respective structures defined above).

```julia
QuantumBilliards.plot_boundary(xs, ns, w)
```

With our associated boundary data, we can now go about approximating the spectra of billiard systems and then solving them for particular resonances. 


```julia
# Detect resonant modes between 1 and 15, evaluating at 2000 interim points (with more points leading to higher to accuracy)
spectrum = QuantumBilliards.resonant_modes(1.0, 15.0, 2000, xs, ns, w) # here, 2000 is 

# Isolate a resonant mode and produce the associated bound state solution on the billiard
test_res = spectrum[7] # picking the seventh mode
QuantumBilliards.plot_billiard(xs, ns, w, test_res)
```

To determine whether our number of boundary nodes (N) and evaluation points is sufficient for detecting the full spectrum in the chosen region, it is often helpful to compare the number of detected resonances to the Weyl prediction for the given billiard. The following function produces a graph comparing the Weyl prediction to the approximated spectrum, with closer correlation being a good indicator of the sufficiency of the chosen parameters. 

```julia
QuantumBilliards.plot_weylcomp(spectrum, geom_data)
```

Finally, the spectra of such systems is often used to define ideas of quantum chaos. Discovered by Bohigas, Giannoni, and Schmit, the level spacing (Wigner-Dyson) distributions of the Weyl unfolded spectra of classically regular and chaotic systems follow Poisson and Gaussian Ensemble distributions respectively. The following function unfolds a given spectrum and produces a histogram of the spacing distributions. Note: this behaviour is clearer at higher frequencies, which are harder to approximate using BEM methods.

```julia
QuantumBilliards.plot_unfolded_spacings(spectrum, geom_data)
```
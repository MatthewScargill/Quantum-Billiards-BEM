# helmholtz-bem-billiards
Boundary Element Method (BEM) toolkit for the 2D Helmholtz equation in billiard domains (circle, rectangle/square, cardioid, stadium in progress). It assembles boundary integral operators, scans wavenumbers to find resonant modes, and includes simple visualisation and spectral statistics utilities.

Features
	•	Domains: Circle, Rectangle/Square, Cardioid (stadium WIP)
	•	BEM building blocks: boundary parameterisations, tangents/normals, quadrature weights
	•	Operators: single-layer (and hooks for others)
	•	Resonance search: scan k and detect minima of singular values
	•	Visualisation: quick plots of boundaries and resonance diagnostics
	•	Spectral tools: unfolding and nearest-neighbour spacing stats (Wigner–Dyson, etc.)
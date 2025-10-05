using .QuantumBilliards
#import numpy as np
N = 600

xs, ns, w = QuantumBilliards.cardioid_info(N)

boundary_info = xs, ns, w

#QuantumBilliards.plot_boundary(boundary_info)

#QuantumBilliards.plot_billiard(xs, ns, w, 6.397593297483047)


#3.1987966487415234
#10.2323

#print(sqrt(10.2323) * 2)


spectrum = QuantumBilliards.resonant_modes(1.0, 15.0, 2000, xs, ns, w)

print(length(spectrum))
#geom_data = (1.4142135623730951, 4.82842712474619)
geom_data = ((3/2)*π, 8)

#
QuantumBilliards.plot_weylcomp(spectrum,geom_data)
#QuantumBilliards.plot_unfolded_spacings(spectrum, geom_data)
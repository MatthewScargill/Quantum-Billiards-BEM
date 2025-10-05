using .QuantumBilliards
#import numpy as np
N = 20

xs, ns, w = QuantumBilliards.rect_info(N)

boundary_info = xs, ns, w

QuantumBilliards.plot_boundary(boundary_info)

#QuantumBilliards.plot_billiard(xs, ns, w, 6.397593297483047)


#3.1987966487415234
#10.2323

#print(sqrt(10.2323) * 2)


#spectrum = QuantumBilliards.resonant_modes(1.0, 20.0, 5000, xs, ns, w)
#print(res)

#geom_data = (3.1416, 6.283)

#QuantumBilliards.plot_weylcomp(spectrum, geom_data)
using .QuantumBilliards
#import numpy as np
N = 100

boundary_info = QuantumBilliards.stadium_info(N)

QuantumBilliards.plot_boundary(boundary_info)

#QuantumBilliards.plot_billiard(xs, ns, w, 6.397593297483047)


#3.1987966487415234
#10.2323

#print(sqrt(10.2323) * 2)


#res = QuantumBilliards.resonant_modes(1.0, 10.0, 700, xs, ns, w)
#print(res)

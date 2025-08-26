using .QuantumBilliards

N = 400

xs, ns, w = QuantumBilliards.circle_info(N)
#print(xs)

QuantumBilliards.resonant_modes(N, 1.0, 15.0, 200, xs, ns, w)
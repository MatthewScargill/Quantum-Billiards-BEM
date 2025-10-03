using .QuantumBilliards

N = 600

xs, ns, w = QuantumBilliards.square_info(N)


res = QuantumBilliards.resonant_modes(1.0, 10.0, 700, xs, ns, w)
print(res)

#QuantumBilliards.plot_boundary((xs, ns, w); normal_scale=0.1, step=5)
using .QuantumBilliards

function build_BEM_matrix_midpoint(k::Float64, xs, ns, w; interior::Bool=true)
    N = length(xs)
    A = zeros(ComplexF64, N, N)
    jump = interior ? -0.5 : 0.5

    for i in 1:N
        A[i,i] = jump                # jump term only
        xi = xs[i]
        for j in 1:N
            if i == j
                continue             # PV(self) = 0 for straight panel midpoint; keep only jump
            end
            A[i,j] += kernel_bem(xi, xs[j], ns[j], k) * w[j]  # use SOURCE normal ns[j]
        end
    end
    return A
end

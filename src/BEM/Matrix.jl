using QuantumBilliards

function build_BEM_matrix(k::Float64, N::Int, xs, ns, w)
    
    A = zeros(ComplexF64, N, N)
    for i in 1:N
        for j in 1:N
            A[i,j] = QuantumBilliards.kernel_bem(xs[i], xs[j], ns[i], k) * w[j]
        end
    end
    return A, θs, xs, ns, w
end

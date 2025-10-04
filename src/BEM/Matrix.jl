using .QuantumBilliards

function build_BEM_matrix(k::Float64, xs, ns, w; interior::Bool=true)
    N = length(xs)
    A = zeros(ComplexF64, N, N)
    jump = interior ? -0.5 : 0.5 # interior or exterior jump term

    for i in 1:N
        A[i,i] = jump                
        xi = xs[i]
        for j in 1:N
            if i == j
                continue             
            end
            A[i,j] += kernel_bem(xi, xs[j], ns[j], k) * w[j] 
        end
    end
    return A
end

using .QuantumBilliards
using Base.Threads
 
@inline function build_BEM_matrix(k::Float64,
                          xs::AbstractVector{SVector{2,Float64}},
                          ns::AbstractVector{SVector{2,Float64}},
                          w::AbstractVector{Float64},
                          H::HankelTable;
                          interior::Bool = true)
    N = length(xs)
    A = Matrix{ComplexF64}(undef, N, N)
    jump = interior ? -0.5 : 0.5 # interior or exterior jump term

    @threads :static for i in 1:N
        xi = xs[i]
        @inbounds begin
            for j in 1:i-1
                A[i,j] = kernel_bem(xi, xs[j], ns[j], k, H) * w[j]
            end
            A[i,i] = jump + 0im
            for j in i+1:N
                A[i,j] = kernel_bem(xi, xs[j], ns[j], k, H) * w[j]
            end
        end
    end
    return A
end

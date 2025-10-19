using LinearAlgebra
using .QuantumBilliards

function compute_phi(k::Float64, xs::Vector{Vector{Float64}}, ns::Vector{Vector{Float64}},
    w::Vector{Float64}; interior::Bool=true)

    N = length(xs)
    @assert length(ns) == N == length(w) "xs, ns, w must have same length"
    A = QuantumBilliards.build_BEM_matrix(k, xs, ns, w; interior=interior)
    S = svd(A)
    phi = S.V[:, end]
    return phi, A
end

function u_interior(x::Vector{Float64}, phi::Vector{ComplexF64}, xs::Vector{Vector{Float64}},
    ns::Vector{Vector{Float64}}, w::Vector{Float64}, k::Float64)
    N = length(xs)

    @assert length(ns) == N == length(w) == length(phi)
    acc = 0.0 + 0im
    @inbounds for j in 1:N
        acc += w[j] * kernel_bem(x, xs[j], ns[j], k) * phi[j]
    end
    return acc
end

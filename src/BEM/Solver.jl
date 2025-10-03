using LinearAlgebra
using SpecialFunctions
using .QuantumBilliards

function compute_phi(k::Float64, xs, ns, w; interior::Bool=true)
    N = length(xs)
    @assert length(ns) == N == length(w) "xs, ns, w must have same length"
    A = QuantumBilliards.build_BEM_matrix(k, xs, ns, w; interior=interior)
    S = svd(A)
    φ = S.V[:, end]             # singular vector for σ_min
    return φ, A
end

function u_interior(x::Vector{Float64}, φ::Vector{ComplexF64},
                    xs, ns, w, k::Float64)
    N = length(xs)
    @assert length(ns) == N == length(w) == length(φ)
    acc = 0.0 + 0im
    @inbounds for j in 1:N
        acc += w[j] * kernel_bem(x, xs[j], ns[j], k) * φ[j]   # SOURCE normal ns[j]
    end
    return acc
end

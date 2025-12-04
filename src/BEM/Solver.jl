using LinearAlgebra
using .QuantumBilliards

@inline function compute_phi(k::Float64, xs::AbstractVector{SVector{2,Float64}}, ns::AbstractVector{SVector{2,Float64}},
    w::Vector{Float64}, tab::HankelTable; interior::Bool=true)

    N = length(xs)
    @assert length(ns) == N == length(w) "xs, ns, w must have same length"

    A = QuantumBilliards.build_BEM_matrix(k, xs, ns, w, tab; interior=interior)
    S = svd(A) # single solve so no need for it to be krylov
    phi = S.V[:, end]
    return phi, A
end

@inline function u_interior(x::Vector{Float64}, phi::Vector{ComplexF64}, xs::AbstractVector{SVector{2,Float64}},
    ns::AbstractVector{SVector{2,Float64}}, w::Vector{Float64}, k::Float64, tab::HankelTable)
    N = length(xs)

    @assert length(ns) == N == length(w) == length(phi)

    val = 0.0 + 0im
    @inbounds for j in 1:N
        val += w[j] * kernel_bem(x, xs[j], ns[j], k, tab) * phi[j]
    end
    return val
end

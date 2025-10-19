using LinearAlgebra
using SpecialFunctions   # for Hankel functions
using .QuantumBilliards

# 2D Helmholtz Green's function 
# Returns the kernel value for field point x and boundary point y with normal n.
@inline function kernel_bem(x::SVector{2,Float64}, y::SVector{2,Float64}, 
    n::SVector{2,Float64}, k::Float64, H::QuantumBilliards.HankelTable) 
    rvec = x .- y
    r = norm(rvec)
    if r < TOL
        return 0.0 + 0im  # jump term taken care of in matrix construction
    else
        proj = dot(rvec, n) / r
        kr   = k * r
        h1   = hankel_eval(H, kr)
        return (im * k / 4) * h1 * proj
    end
end

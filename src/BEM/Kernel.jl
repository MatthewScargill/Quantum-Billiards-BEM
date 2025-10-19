using LinearAlgebra
using SpecialFunctions   # for Hankel functions

const TOL = 1e-14

# 2D Helmholtz Green's function 
# Returns the kernel value for field point x and boundary point y with normal n.
@inline function kernel_bem(x::SVector{2,Float64}, y::SVector{2,Float64}, 
    n::SVector{2,Float64}, k::Float64) 
    rvec = x .- y
    r = norm(rvec)
    if r < TOL
        return 0.0 + 0im  # jump term taken care of in matrix construction
    else
        return (im * k / 4) * besselh(1, 1, k*r) * (dot(rvec, n) / r)
    end
end

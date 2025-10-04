using LinearAlgebra
using SpecialFunctions   # for Hankel functions

# 2D Helmholtz Green's function 
# Returns the kernel value for field point x and boundary point y with normal n.
function kernel_bem(x::Vector{Float64}, y::Vector{Float64}, n::Vector{Float64}, k::Float64)
    rvec = x .- y
    r = norm(rvec)
    if r < 1e-14
        return 0.0 + 0im  # jump term taken care of in matrix construction
    else
        return (im * k / 4) * besselh(1, 1, k*r) * (dot(rvec, n) / r)
    end
end

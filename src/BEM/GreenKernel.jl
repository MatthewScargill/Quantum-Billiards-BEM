using LinearAlgebra
using SpecialFunctions   # for Hankel functions

# 2D Helmholtz Green's function 
# Returns the kernel value for field point x and boundary point y with normal n.
function kernel_bem(x::Vector{Float64}, y::Vector{Float64}, n::Vector{Float64}, k::Float64)
    d = norm(x - y)
    tol = 1e-10
    if d < tol
        return -0.5 # Use jump formula for small norms
    else
        return (im * k / 4) * besselh(1, 1, k*d) * dot(x - y, n) / d
    end
end
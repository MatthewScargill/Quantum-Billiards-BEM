module Cardioid

using LinearAlgebra
using SpecialFunctions   # For Hankel functions

# Boundary parameterization for the cardioid 

export cardioid_boundary

function cardioid_boundary(θ)
    r = 1 + cos(θ)
    return [r * cos(θ), r * sin(θ)]
end

export cardioid_derivative

function cardioid_derivative(θ)
    r = 1 + cos(θ)
    rp = -sin(θ)
    dx = rp*cos(θ) - r*sin(θ)
    dy = rp*sin(θ) + r*cos(θ)
    return [dx, dy]
end

export outward_normal

function outward_normal(θ)
    d = cardioid_derivative(θ)
    n = [d[2], -d[1]]
    return n / norm(n)
end

export quadrature_weights

function quadrature_weights(θs)
    N = length(θs)
    w = zeros(Float64, N)
    dθ = θs[2] - θs[1]
    for (i, θ) in enumerate(θs)
        w[i] = norm(cardioid_derivative(θ)) * dθ
    end
    return w
end

export cardioid_info

function cardioid_info(k::Float64, N::Int)
    θs = range(2π, 4π, length=N+1)[1:end-1]  # exclude duplicate endpoint
    xs = [cardioid_boundary(θ) for θ in θs]
    ns = [outward_normal(θ) for θ in θs]
    w = quadrature_weights(collect(θs))
    return θs, xs, ns, w
end

end # of the module

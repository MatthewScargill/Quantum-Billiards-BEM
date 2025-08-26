using LinearAlgebra
using SpecialFunctions   # For Hankel functions

# Boundary parameterization for the cardioid 
function cardioid_boundary(θ)
    r = 1 + cos(θ)
    return [r * cos(θ), r * sin(θ)]
end

function cardioid_derivative(θ)
    r = 1 + cos(θ)
    rp = -sin(θ)
    dx = rp*cos(θ) - r*sin(θ)
    dy = rp*sin(θ) + r*cos(θ)
    return [dx, dy]
end

function cardioid_outward_normal(θ)
    d = cardioid_derivative(θ)
    n = [d[2], -d[1]]
    return n / norm(n)
end

function cardioid_quadrature_weights(θs)
    N = length(θs)
    w = zeros(Float64, N)
    dθ = θs[2] - θs[1]
    for (i, θ) in enumerate(θs)
        w[i] = norm(cardioid_derivative(θ)) * dθ
    end
    return w
end

function cardioid_info( N::Int)
    θs = range(2π, 4π, length=N+1)[1:end-1]  # exclude duplicate endpoint
    xs = [cardioid_boundary(θ) for θ in θs]
    ns = [cardioid_outward_normal(θ) for θ in θs]
    w = cardioid_quadrature_weights(collect(θs))
    return θs, xs, ns, w
end

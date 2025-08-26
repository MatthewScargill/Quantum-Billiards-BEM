module Circle

using LinearAlgebra
using SpecialFunctions   # For Hankel functions

# Boundary parameterization for the cardioid 

export circle_boundary

function circle_boundary(θ)
    r = 1 
    return [r * cos(θ), r * sin(θ)]
end

export circle_derivative


function circle_derivative(θ)
    dx = - sin(θ)
    dy = cos(θ)
    return [dx, dy]
end


export circle_outward_normal

function circle_outward_normal(θ)
    d = cardioid_derivative(θ)
    n = [d[2], -d[1]]
    return n / norm(n)
end


export circle_quadrature_weights

function circle_quadrature_weights(θs)
    N = length(θs)
    w = zeros(Float64, N)
    dθ = θs[2] - θs[1]
    for (i, θ) in enumerate(θs)
        w[i] = norm(circle_derivative(θ)) * dθ
    end
    return w
end


export circle_info

function circle_info( N::Int)
    θs = range(2π, 4π, length=N+1)[1:end-1]  # exclude duplicate endpoint
    xs = [circle_boundary(θ) for θ in θs]
    ns = [circle_outward_normal(θ) for θ in θs]
    w = circle_quadrature_weights(collect(θs))
    return θs, xs, ns, w
end

end # of the module

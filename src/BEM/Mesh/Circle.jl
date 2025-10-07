# Boundary parameterization for the unit circle 
function circle_boundary(θ)
    r = 1 
    return [r * cos(θ), r * sin(θ)]
end

function circle_derivative(θ)
    dx = - sin(θ)
    dy = cos(θ)
    return [dx, dy]
end

function circle_outward_normal(θ)
    d = circle_derivative(θ)
    n = [d[2], -d[1]]
    return n / norm(n)
end

function circle_quadrature_weights(rng)
    N = length(rng)
    w = zeros(Float64, N)
    drng = rng[2] - rng[1]
    for (i, θ) in enumerate(rng)
        w[i] = norm(circle_derivative(θ)) * drng
    end
    return w
end

function circle_info( N::Int)
    rng = range(2π, 4π, length=N+1)[1:end-1]  # exclude duplicate endpoint
    xs = [circle_boundary(θ) for θ in rng]
    ns = [circle_outward_normal(θ) for θ in rng]
    w = circle_quadrature_weights(collect(rng))
    geom_data = (π, 2* π) 
    return xs, ns, w, geom_data
end

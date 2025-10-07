# Boundary parameterization for the Bunimovitch Stadium (with L = 1 and R = 1).
stadium_perimeter(R::Float64, L::Float64) = 2L + 2π*R

function stadium_boundary(s::Float64; R::Float64=1.0, L::Float64=1.0)
    P = stadium_perimeter(R, L)
    s = mod(s, P)

    s1 = π*R           # right semicircle
    s2 = s1 + L        # + top straight
    s3 = s2 + π*R      # + left semicircle
    # s4 = s3 + L == P

    if s < s1
        θ = -π/2 + s/R
        cx, cy =  L/2, 0.0
        return [cx + R*cos(θ), cy + R*sin(θ)]

    elseif s < s2
        u = s - s1
        return [L/2 - u, R]

    elseif s < s3
        θ =  π/2 + (s - s2)/R
        cx, cy = -L/2, 0.0
        return [cx + R*cos(θ), cy + R*sin(θ)]

    else
        u = s - s3
        return [-L/2 + u, -R]
    end
end

function stadium_derivative(s::Float64; R::Float64=1.0, L::Float64=1.0)
    P = stadium_perimeter(R, L)
    s = mod(s, P)

    s1 = π*R
    s2 = s1 + L
    s3 = s2 + π*R

    if s < s1
        θ = -π/2 + s/R
        # Unit tangent for circle CCW: [-sinθ, cosθ]
        return [-sin(θ), cos(θ)]

    elseif s < s2
        # Top straight moving left
        return [-1.0, 0.0]

    elseif s < s3
        θ =  π/2 + (s - s2)/R
        return [-sin(θ), cos(θ)]

    else
        # Bottom straight moving right
        return [1.0, 0.0]
    end
end

function stadium_outward_normal(s::Float64; R::Float64=1.0, L::Float64=1.0)
    P = stadium_perimeter(R, L)
    s = mod(s, P)

    s1 = π*R
    s2 = s1 + L
    s3 = s2 + π*R

    if s < s1
        θ = -π/2 + s/R
        # Radial outward normal on right semicircle:
        return [cos(θ), sin(θ)]

    elseif s < s2
        # Top straight: interior is below → outward is +y
        return [0.0, 1.0]

    elseif s < s3
        θ =  π/2 + (s - s2)/R
        # Radial outward normal on left semicircle:
        return [cos(θ), sin(θ)]

    else
        # Bottom straight: interior is above → outward is -y
        return [0.0, -1.0]
    end
end

function stadium_quadrature_weights(s_vals::AbstractVector{<:Real}; R::Float64=1.0, L::Float64=1.0)
    N = length(s_vals)
    ds = stadium_perimeter(R, L) / N
    return fill(ds, N)
end

function stadium_info(N::Int; R::Float64=1.0, L::Float64=1.0)
    P = stadium_perimeter(R, L)
    s_vals = collect(range(0, stop=P, length=N+1))[1:end-1]   # exclude duplicate endpoint
    xs = [stadium_boundary(s; R=R, L=L) for s in s_vals]
    ns = [stadium_outward_normal(s; R=R, L=L) for s in s_vals]
    w  = stadium_quadrature_weights(s_vals; R=R, L=L)
    geom_data = ((R^2)*π +2*R*L, 2L + 2π*R)
    return xs, ns, w, geom_data
end
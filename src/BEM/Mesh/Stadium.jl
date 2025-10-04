# --- Bunimovitch Stadium (CCW) ---

# Perimeter
stadium_perimeter(R::Float64, L::Float64) = 2L + 2π*R

"""
    stadium_boundary(s; R, L)

Arclength parameterization (CCW) of the stadium boundary.
- Semicircles of radius R centered at (±L/2, 0)
- Straight segments of length L at y=±R
Input:
  s ∈ [0, P), P = 2L + 2πR (wrapped internally)
Returns: [x, y]
"""
function stadium_boundary(s::Float64; R::Float64=1.0, L::Float64=1.0)
    P = stadium_perimeter(R, L)
    s = mod(s, P)

    s1 = π*R           # right semicircle
    s2 = s1 + L        # + top straight
    s3 = s2 + π*R      # + left semicircle
    # s4 = s3 + L == P

    if s < s1
        # Right semicircle: θ from -π/2 → +π/2
        θ = -π/2 + s/R
        cx, cy =  L/2, 0.0
        return [cx + R*cos(θ), cy + R*sin(θ)]

    elseif s < s2
        # Top straight: (L/2, R) → (-L/2, R)
        u = s - s1
        return [L/2 - u, R]

    elseif s < s3
        # Left semicircle: θ from +π/2 → +3π/2
        θ =  π/2 + (s - s2)/R
        cx, cy = -L/2, 0.0
        return [cx + R*cos(θ), cy + R*sin(θ)]

    else
        # Bottom straight: (-L/2, -R) → (L/2, -R)
        u = s - s3
        return [-L/2 + u, -R]
    end
end

"""
    stadium_derivative(s; R, L)

Unit tangent vector (dx/ds, dy/ds) along the stadium boundary (since s is arclength).
"""
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

"""
    stadium_outward_normal(s; R, L)

Outward unit normal at boundary point parametrized by s.
"""
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

"""
    stadium_quadrature_weights(s_vals; R, L)

Uniform arclength weights for a stadium parameterized by arclength s.
"""
function stadium_quadrature_weights(s_vals::AbstractVector{<:Real}; R::Float64=1.0, L::Float64=1.0)
    N = length(s_vals)
    ds = stadium_perimeter(R, L) / N
    return fill(ds, N)
end

"""
    stadium_info(N; R=1.0, L=1.0)

Generate boundary midpoints, outward normals, and panel weights for a
Bunimovitch stadium. The sampling is uniform in arclength and avoids
duplicating the endpoint.

Returns: xs, ns, w  (same types as your circle_info)
"""
function stadium_info(N::Int; R::Float64=1.0, L::Float64=1.0)
    P = stadium_perimeter(R, L)
    s_vals = collect(range(0, stop=P, length=N+1))[1:end-1]   # N points, no duplicate
    xs = [stadium_boundary(s; R=R, L=L) for s in s_vals]
    ns = [stadium_outward_normal(s; R=R, L=L) for s in s_vals]
    w  = stadium_quadrature_weights(s_vals; R=R, L=L)
    return xs, ns, w
end
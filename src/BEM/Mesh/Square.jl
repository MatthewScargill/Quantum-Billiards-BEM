# Boundary parameterization for the unit square.
Lx = 1.0
Ly = 1.0
L_total = 2*(Lx + Ly)  # total boundary length

function square_boundary(s::Float64)
    if s < Lx
        # Bottom edge: from (0,0) to (Lx,0)
        return [s, 0.0]
    elseif s < Lx + Ly
        # Right edge: from (Lx,0) to (Lx,Ly)
        s2 = s - Lx
        return [Lx, s2]
    elseif s < 2*Lx + Ly
        # Top edge: from (Lx,Ly) to (0,Ly)
        s3 = s - (Lx + Ly)
        return [Lx - s3, Ly]
    else
        # Left edge: from (0,Ly) to (0,0)
        s4 = s - (2*Lx + Ly)
        return [0.0, Ly - s4]
    end
end

function square_derivative(s::Float64)
    if s < Lx
        return [1.0, 0.0]   # bottom edge
    elseif s < Lx + Ly
        return [0.0, 1.0]   # right edge
    elseif s < 2*Lx + Ly
        return [-1.0, 0.0]  # top edge
    else
        return [0.0, -1.0]  # left edge
    end
end

function square_outward_normal(s::Float64)
    if s < Lx
        return [0.0, -1.0]      # bottom edge: interior is above, so outward points down
    elseif s < Lx + Ly
        return [1.0, 0.0]       # right edge: interior is left, so outward points right
    elseif s < 2*Lx + Ly
        return [0.0, 1.0]       # top edge: interior is below, so outward points up
    else
        return [-1.0, 0.0]      # left edge: interior is right, so outward points left
    end
end

function square_quadrature_weights(s_vals)
    N = length(s_vals)
    ds = L_total / N
    return fill(ds, N)
end

function square_info( N::Int)
    s_vals = collect(range(0, stop=L_total, length=N+1))[1:end-1]  # avoid duplicating endpoint
    xs = [square_boundary(s) for s in s_vals]
    ns = [square_outward_normal(s) for s in s_vals]
    w = square_quadrature_weights(s_vals)
    geom_data = (1, 4)
    return xs, ns, w, geom_data
end

# Boundary parameterization for the rectangle (with rrLx = 1 and rLy = sqrt(2)).
rLx = 1.0
rLy = sqrt(2)
rL_total = 2*(rLx + rLy)  # total boundary length

function rect_boundary(s::Float64)
    if s < rLx
        # Bottom edge: from (0,0) to (rLx,0)
        return [s, 0.0]
    elseif s < rLx + rLy
        # Right edge: from (rLx,0) to (rLx,rLy)
        s2 = s - rLx
        return [rLx, s2]
    elseif s < 2*rLx + rLy
        # Top edge: from (rLx,rLy) to (0,rLy)
        s3 = s - (rLx + rLy)
        return [rLx - s3, rLy]
    else
        # Left edge: from (0,rLy) to (0,0)
        s4 = s - (2*rLx + rLy)
        return [0.0, rLy - s4]
    end
end

function rect_derivative(s::Float64)
    if s < rLx
        return [1.0, 0.0]   # bottom edge
    elseif s < rLx + rLy
        return [0.0, 1.0]   # right edge
    elseif s < 2*rLx + rLy
        return [-1.0, 0.0]  # top edge
    else
        return [0.0, -1.0]  # left edge
    end
end

function rect_outward_normal(s::Float64)
    if s < rLx
        return [0.0, -1.0]      # bottom edge: interior is above, so outward points down
    elseif s < rLx + rLy
        return [1.0, 0.0]       # right edge: interior is left, so outward points right
    elseif s < 2*rLx + rLy
        return [0.0, 1.0]       # top edge: interior is below, so outward points up
    else
        return [-1.0, 0.0]      # left edge: interior is right, so outward points left
    end
end

function rect_quadrature_weights(s_vals)
    N = length(s_vals)
    ds = rL_total / N
    return fill(ds, N)
end

function rect_info( N::Int)
    s_vals = collect(range(0, stop=rL_total, length=N+1))[1:end-1]  # avoid duplicating endpoint
    xs = [rect_boundary(s) for s in s_vals]
    ns = [rect_outward_normal(s) for s in s_vals]
    w = rect_quadrature_weights(s_vals)
    geom_data = (rLy * rLx, rL_total) 
    return xs, ns, w, geom_data
end

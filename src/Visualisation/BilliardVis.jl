using LinearAlgebra
using Plots

function is_inside(x::Vector{Float64}, xs::Vector{Vector{Float64}})::Bool
    n = length(xs)
    inside = false
    px, py = x[1], x[2]

    for i in 1:n
        j = (i == n) ? 1 : i + 1
        x1, y1 = xs[i][1], xs[i][2]
        x2, y2 = xs[j][1], xs[j][2]

        # check if ray crosses the edge
        if ((y1 > py) != (y2 > py))
            xint = x1 + (py - y1) * (x2 - x1) / (y2 - y1 + eps())
            if px < xint
                inside = !inside
            end
        end
    end
    return inside
end


function plot_billiard(xs,ns,w,k)

    # setup
    num_pts = 200
    padding=0.05

    # tight plotting box from boundary with small padding
    X = reduce(hcat, xs)'                 # (N, 2)
    xmin, xmax = minimum(X[:,1]), maximum(X[:,1])
    ymin, ymax = minimum(X[:,2]), maximum(X[:,2])
    dx, dy = xmax - xmin, ymax - ymin
    
    xlo, xhi = xmin - padding, xmax + padding
    ylo, yhi = ymin - padding, ymax + padding

    xgrid = range(xlo, xhi, length=num_pts)
    ygrid = range(ylo, yhi, length=num_pts)
    u_vals = Array{Float64}(undef, num_pts, num_pts)  # to store |u(x)|


    phi, _ = compute_phi(k, xs, ns, w)

    for (i, x_val) in enumerate(xgrid)
        for (j, y_val) in enumerate(ygrid)
            x = [x_val, y_val]
            # only compute u(x) if x is inside the boundary; otherwise, assign NaN
            if is_inside(x, xs) == true
                u_vals[j, i] = abs(u_interior(x, phi, xs, ns, w, k))
            else
                u_vals[j, i] = NaN
            end
        end
    end

    # draw heatmap
    heatmap(xgrid, ygrid, u_vals,
        xlabel = "x",
        ylabel = "y",
        colorbar_title = "|u(x)|",
        aspect_ratio = 1)

end 
 
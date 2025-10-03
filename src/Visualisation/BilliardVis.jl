using LinearAlgebra
using Plots

function plot_billiard(xs,ns,w,k)

    # Create a grid covering the square [-1,1]×[-1,1] and evaluate u(x) only for points inside the circle.
    num_pts = 200
    xgrid = range(-1, stop=1, length=num_pts)
    ygrid = range(-1, stop=1, length=num_pts)
    u_vals = Array{Float64}(undef, num_pts, num_pts)  # to store |u(x)|

    phi, A = compute_phi(k, xs, ns, w)

    for (i, x_val) in enumerate(xgrid)
        for (j, y_val) in enumerate(ygrid)
            x = [x_val, y_val]
            # Only compute u(x) if x is inside the circle; otherwise, assign NaN.
            if norm(x) <= 1
                u_vals[j, i] = abs(u_interior(x, phi, xs, ns, w, k))
            else
                u_vals[j, i] = NaN
            end
        end
    end

    heatmap(xgrid, ygrid, u_vals,
        xlabel = "x",
        ylabel = "y",
        title = "Interior Wavefunction Magnitude |u(x)| on the Unit Disk (k = $(k))",
        colorbar_title = "|u(x)|",
        aspect_ratio = 1)

end 

using Plots

function plot_boundary(xs::Vector{Vector{Float64}}, ns::Vector{Vector{Float64}},
    w::Vector{Float64}; normal_scale=0.12, step=1)

    # Convert to arrays
    X = reduce(hcat, xs)'   # (N, 2)
    Nn = reduce(hcat, ns)'  # (N, 2)

    # boundary polygon (closed loop)
    xcoords = vcat(X[:,1], X[1,1])
    ycoords = vcat(X[:,2], X[1,2])

    plt = plot(xcoords, ycoords;
        linewidth=2,
        aspect_ratio=:equal,
        xlabel="x", ylabel="y",
        title="Boundary with outward normals",
        legend=false
    )

    # Add normals
    for i in 1:step:size(X,1)
        x, y = X[i, :]
        nx, ny = Nn[i, :]
        plot!([x, x + normal_scale*nx], [y, y + normal_scale*ny],
              arrow=:arrow, linewidth=1.5, color=:red) # adding arrows (thanks julia that was easy)
    end

    return plt
end

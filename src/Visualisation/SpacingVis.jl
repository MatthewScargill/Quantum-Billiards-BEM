using .QuantumBilliards
using StatsBase

# add option to overlay poisson and or GOE
function plot_unfolded_spacings(spectrum::AbstractVector{<:Real}, geom_data::Tuple{<:Real,<:Real}; overlay::Bool = false)

    unfolded_spectrum = weyl_unfold(spectrum, geom_data)
    spacings = QuantumBilliards.spectrum_spacings(unfolded_spectrum)

    bin_width = 0.2
    smax = maximum(spacings)
    edges = 0:bin_width:(smax + bin_width)

    # Compute histogram 
    hist = fit(Histogram, spacings, edges)
    # Relative frequency: each bin's count divided by the total number of spacings
    rel_freq = hist.weights / sum(hist.weights)
    # Compute bin centers
    bin_centers = [ (edges[i] + edges[i+1]) / 2 for i in 1:length(edges)-1 ]

    p = bar(bin_centers, rel_freq, width=bin_width,
        xlabel="Spacing (ΔN, unfolded via Weyl's law)",
        ylabel="Relative Frequency",
        title="Histogram of Spacings of the Unfolded Spectrum",
        label="Data")


    # for comparison to ...
    if overlay

        xs = range(0, stop = smax, length = 400)
        
        # possion -> integrable 
        poisson_pdf(s) = exp(-s)
        poisson_vals = poisson_pdf.(xs) .* bin_width
        plot!(p, xs, poisson_vals, label = "Poisson", lw = 2)

        # GOE -> chaotic
        goe_pdf(s) = (π/2) * s * exp(-π * s^2 / 4)
        goe_vals = goe_pdf.(xs) .* bin_width
        plot!(p, xs, goe_vals, label = "GOE", lw = 2)
    end



end

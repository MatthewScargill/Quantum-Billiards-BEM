# graph comparing unfolded spectrum to weyl estimation 
using Plots
using .QuantumBilliards

function plot_weylcomp(spectrum::AbstractVector{<:Real}, geom_data::Tuple{<:Real,<:Real})
    

    num_points::Int=1000

    @assert !isempty(spectrum) "Spectrum must not be empty."

    ks = sort(collect(spectrum))
    kmax = maximum(ks)
    kgrid = range(0, kmax; length=num_points)

    # empirical staircase N(k): count how many levels ≤ k
    N_emp = [weyl_count(ks, k) for k in kgrid]

    # smooth Weyl prediction N̄(k)
    N_weyl = [weyl_convert(k, geom_data) for k in kgrid]

    # plot the comparison
    plot(kgrid, N_emp;
         seriestype = :steppost,
         lw = 2,
         label = "Empirical N(k)",
         xlabel = "k",
         ylabel = "Count")

    plot!(kgrid, N_weyl;
          lw = 2,
          label = "Weyl N̄(k)")
end
using LinearAlgebra
using SpecialFunctions
using .QuantumBilliards

function min_singular_value(k::Float64, xs::Vector{Vector{Float64}}, ns::Vector{Vector{Float64}}, 
    w::Vector{Float64})

    A = QuantumBilliards.build_BEM_matrix(k, xs, ns, w; interior=true)
    s = svdvals(A)
    return minimum(s)
end

function resonant_modes(k_min::Float64, k_max::Float64, num_k::Int64,
     xs::Vector{Vector{Float64}}, ns::Vector{Vector{Float64}}, w::Vector{Float64}; thresh=1e-2)

    k_values = collect(range(k_min, k_max, length=num_k))
    min_sv = [min_singular_value(k, xs, ns, w) for k in k_values]
    # naive peak picker on downward spikes
    idx = Int[]
    for i in 2:length(min_sv)-1
        if min_sv[i] < min(min_sv[i-1], min_sv[i+1]) && min_sv[i] < thresh
            push!(idx, i)
        end
    end
    return k_values[idx]
end

# make min_singular_value just take in A
# initialise tab at beginning of resonant_modes
# matrix construction is a lot lighter with tab so can chuck in a loop and not feel too plot_boundary
# 
using LinearAlgebra
using SpecialFunctions
using .QuantumBilliards
using Base.Threads

function resonant_modes(k_min::Float64, k_max::Float64, num_k::Int64,
     xs::AbstractVector{SVector{2,Float64}}, ns::AbstractVector{SVector{2,Float64}}, 
     w::AbstractVector{Float64}; thresh=1e-2)

    # initialise tabulation
    tab = tabulate_hankel(xs, k_min, k_max)

    # scanned k values 
    k_values = collect(range(k_min, k_max, length=num_k))

    ks = collect(range(k_min, k_max; length = num_k))
    min_sv = Vector{Float64}(undef, num_k)

    #"""outdated full svg decomposition
    

    # finding min sv val of each generated bem matrix
    for (t, k) in enumerate(ks)
        A = build_BEM_matrix(k, xs, ns, w, tab)
        svals = svdvals(A)
        min_sv[t] = svals[end]
    end
    #"""
    """
    v0 = nothing
    for (t, k) in enumerate(ks)
        A = build_BEM_matrix(k, xs, ns, w, tab)
        theta, v0 = min_singular(A, v0=v0)   # warm start
        min_sv[t] = theta
    end
    """
    

    # naive peak picker on downward spikes
    idx = Int[]
    for i in 2:length(min_sv)-1
        if min_sv[i] < min(min_sv[i-1], min_sv[i+1]) && min_sv[i] < thresh
            push!(idx, i)
        end
    end

    return k_values[idx]
end

using LinearAlgebra
using SpecialFunctions
using .QuantumBilliards


function min_singular_value(A::Matrix{ComplexF64})
    s = svdvals(A)
    return minimum(s)
end

function resonant_modes(k_min::Float64, k_max::Float64, num_k::Int64,
     xs, ns, w; thresh=1e-2)

    # initialise tabulation
    tab = tabulate_hankel(xs, k_min, k_max)

    # scanned k values 
    k_values = collect(range(k_min, k_max, length=num_k))

    ks = collect(range(k_min, k_max; length = num_k))
    min_sv = Vector{Float64}(undef, num_k)

    for (t, k) in enumerate(ks)
        A = build_BEM_matrix(k, xs, ns, w, tab)
        # Smallest singular value (svdvals returns descending)
        svals = svdvals(A)
        min_sv[t] = svals[end]
    end


    # naive peak picker on downward spikes
    idx = Int[]
    for i in 2:length(min_sv)-1
        if min_sv[i] < min(min_sv[i-1], min_sv[i+1]) && min_sv[i] < thresh
            push!(idx, i)
        end
    end
    return k_values[idx]
end
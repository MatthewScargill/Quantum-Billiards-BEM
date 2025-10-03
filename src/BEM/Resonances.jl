using LinearAlgebra
using SpecialFunctions
using .QuantumBilliards

function min_singular_value(k::Float64, xs, ns, w)
    A = QuantumBilliards.build_BEM_matrix_midpoint(k, xs, ns, w; interior=true)
    s = svdvals(A)
    return minimum(s)
end

function resonant_modes(k_min, k_max, num_k, xs, ns, w; thresh=1e-2)
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

using LinearAlgebra
using SpecialFunctions
using .QuantumBilliards

# --- Compute the Minimum Singular Value (for resonance detection) ---
function min_singular_value(k::Float64, N::Int, xs, ns, w)
    A = QuantumBilliards.build_BEM_matrix(k, N, xs, ns, w)
    s = svdvals(A)
    return minimum(s)
end

function resonant_modes(N, k_min, k_max, num_k, xs, ns, w)
    k_values = range(k_min, k_max, length=num_k)
    min_sv = [abs(min_singular_value(k, N, xs, ns, w)) for k in k_values]

    resonant_indices = []
    for i in 2:length(min_sv)-1
        if min_sv[i] < min_sv[i-1] && min_sv[i] < min_sv[i+1] && min_sv[i] < 0.1
            push!(resonant_indices, i)
        end
    end
    resonant_k = k_values[resonant_indices]
    resonant_sv = min_sv[resonant_indices]

    println("Resonant k values:")
    println(resonant_k)

    return resonant_k,resonant_sv
end

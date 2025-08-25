# --- Main Routine ---
# Define parameters for the rectangular BEM problem.
N = 300             # number of boundary elements
k_min = 1.0
k_max = 20.0
num_k = 4000
k_values = range(k_min, k_max, length=num_k)

# Compute the minimum singular value for each k.
min_sv = [abs(min_singular_value_rect(k, N)) for k in k_values]

# --- Compute the Minimum Singular Value (for resonance detection) ---
function min_singular_value_rect(k::Float64, N::Int)
    A, _ = galerkinBEMRect(k, N)
    s = svdvals(A)
    return minimum(s)
end


# Identify candidate resonant frequencies by finding local minima in the min_sv curve.
resonant_indices = []
for i in 2:length(min_sv)-1
    if min_sv[i] < min_sv[i-1] && min_sv[i] < min_sv[i+1] && min_sv[i] < 0.1
        push!(resonant_indices, i)
    end
end
resonant_k = k_values[resonant_indices]
resonant_sv = min_sv[resonant_indices]
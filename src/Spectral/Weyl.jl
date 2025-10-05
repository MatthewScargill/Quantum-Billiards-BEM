# convert to weyl value
function weyl_convert(k::Real, geom_data::Tuple{<:Real,<:Real})
    A, P = geom_data  # (Area, Perimeter)
    return (A/(4π))*k^2 - (P/(4π))*k
end


# take in a spectrum and unfold using weyl counting function
function weyl_unfold(spectrum::AbstractVector{<:Real}, geom_data::Tuple{<:Real,<:Real})
    unfolded_spectrum = []
    for res in spectrum
        push!(unfolded_spectrum, weyl_convert(res, geom_data))
    end
    return unfolded_spectrum
end

# counting function for weylcomp visualisation

# Build the cumulative counting function: for each k in k_values, count resonances below k.
function weyl_count(unfolded_spectrum, k)
    mode_count = 0
    for res in unfolded_spectrum
        if res < k
            mode_count += 1
        else break
        end
    end
    return mode_count
end

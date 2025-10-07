function weyl_convert(k::Float64, geom_data::Tuple{<:Real,<:Real})
    A, P = geom_data  # (Area, Perimeter)
    return (A/(4π))*k^2 - (P/(4π))*k
end

function weyl_unfold(spectrum::AbstractVector{<:Real}, geom_data::Tuple{<:Real,<:Real})
    unfolded_spectrum = []
    for res in spectrum
        push!(unfolded_spectrum, weyl_convert(res, geom_data))
    end
    return unfolded_spectrum
end

function weyl_count(unfolded_spectrum::AbstractVector{<:Real}, k::Float64)
    mode_count = 0
    for res in unfolded_spectrum
        if res < k
            mode_count += 1
        else break # count resonances below k
        end
    end
    return mode_count
end

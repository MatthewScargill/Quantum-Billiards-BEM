function weyl_convert(k::Float64, geom_data::Tuple{<:Real,<:Real})
    A, P = geom_data  # (Area, Perimeter)
    return (A/(4π))*k^2 - (P/(4π))*k
end

function weyl_count(spectrum::Vector{Float64}, k::Float64)
    mode_count = 0
    for res in spectrum
        if res < k
            mode_count += 1
        else break # count resonances below k
        end
    end
    return mode_count
end

function weyl_unfold(spectrum::Vector{Float64}, geom_data::Tuple{<:Real,<:Real})

    unfolded_spectrum = Vector{Float64}()
    for res in spectrum
        push!(unfolded_spectrum, weyl_convert(res, geom_data))
    end
    
    return unfolded_spectrum
end

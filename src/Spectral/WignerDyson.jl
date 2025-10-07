# take in unfolded spectrum and produce spacing spectrum 

function spectrum_spacings(unfolded_spectrum::AbstractVector{<:Real})
    unfolded_spectrum = sort(unfolded_spectrum)
    spacings = diff(unfolded_spectrum)
    return spacings
end

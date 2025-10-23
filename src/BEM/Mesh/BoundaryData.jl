# xs, ns, w all kind of appear in the same places so might as well have one structure 
# for all of them
struct BoundaryData
    xs::AbstractVector{SVector{2,Float64}}
    ns::AbstractVector{SVector{2,Float64}}
    w::AbstractVector{Float64}
    geom_data::Tuple{<:Real,<:Real}
end

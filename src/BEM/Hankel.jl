using StaticArrays, LinearAlgebra, SpecialFunctions, Base.Threads

# storing precomputed Hankel function values for range of k*r_max
# keep an invdkr to map input krs to corresponding hankel values
struct HankelTable
    krmin::Float64 # == min r * min k or k 
    krmax::Float64 # == max r * max k or k 
    invdkr::Float64 # to map input krs to corresponding hankel values
    vals::Vector{ComplexF64} # stored values
end

# find min r and max r 
function r_bounds(xs::Vector{SVector{2,Float64}})

    N = length(xs)

    # finding min r between consecutive points (assuming consecutive points will have smallest distance)
    rmin = minimum(begin
        x  = xs[i]
        xp = xs[mod1(i+1,N)]
        xm = xs[mod1(i-1,N)]
        min(norm(x - xp), norm(x - xm)) 
    end for i in 1:N)

    # distances beneath TOL are taken care of by jump term (see matrix construction)
    # -> only minimum distance that matters is just TOL (set in Kernel.jl)
    rmin = max(rmin, TOL)

    # take max r to be diagonal of the bounding box as a safe upper bound
    xs1 = map(p->p[1], xs); xs2 = map(p->p[2], xs)
    rmax = hypot(maximum(xs1)-minimum(xs1), maximum(xs2)-minimum(xs2))
    return rmin, rmax
end

# build table over [krmin, krmax]
function make_hankel_table(krmin::Float64, krmax::Float64; m::Int=100_000)
    @assert krmax > krmin > 0 "kr bounds must be positive and ordered"
    dkr  = (krmax - krmin) / (m - 1)
    vals = Vector{ComplexF64}(undef, m)
    @threads :static for i in 1:m
        kr = krmin + (i-1)*dkr
        vals[i] = besselh(1, 1, kr)  # H1^(1)(kr)
    end
    tab = HankelTable(krmin, krmax, 1/dkr, vals)
    return tab
end

# single k method
function tabulate_hankel(xs::Vector{SVector{2,Float64}}, k::Float64;
                         m::Int=100_000, margin::Float64=1.05)
    rmin, rmax = r_bounds(xs)
    krmin = max(1e-12, k*rmin/margin)
    krmax = max(krmin*10, k*rmax*margin)
    make_hankel_table(krmin, krmax; m=m)
end

# k range method
function tabulate_hankel(xs::Vector{SVector{2,Float64}}, kmin::Float64, kmax::Float64;
                         m::Int=100_000, margin::Float64=1.05)
    @assert kmax ≥ kmin > 0 "k-range must be positive and ordered"
    rmin, rmax = r_bounds(xs)
    krmin = max(1e-12, kmin*rmin/margin)
    krmax = max(krmin*10, kmax*rmax*margin)
    make_hankel_table(krmin, krmax; m=m)
end

# fast linear interpolation (clamped)
@inline function hankel_eval(tab::HankelTable, kr::Float64)
    t  = (kr - tab.krmin)*tab.invdkr
    n1 = length(tab.vals) - 1
    i  = ifelse(t ≤ 0, 1, ifelse(t ≥ n1, n1, Int(floor(t)) + 1))
    a  = t - (i - 1)
    @inbounds ((1-a)*tab.vals[i] + a*tab.vals[i+1])
end

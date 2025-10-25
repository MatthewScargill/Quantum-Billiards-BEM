using LinearAlgebra
using KrylovKit

# welcome to me trying to optimise the svd finder
function min_singular(A; v0=nothing, tol=1e-8, maxiter=300, krylovdim=30, nev=1)
    n = size(A,2)
    v0 === nothing && (v0 = randn(n))
    v0 ./= norm(v0)

    # Linear operator
    op = x -> A' * (A * x)

    vals, vecs, _ = eigsolve(op, v0, max(1, nev), :SR;
                                ishermitian=true,
                                tol=tol, maxiter=maxiter, krylovdim=krylovdim)

    
    j = argmin(vals)
    λ = real(vals[j])
    v = vecs[j]
    sigma = sqrt(max(λ, 0.0))
    return sigma, v
end

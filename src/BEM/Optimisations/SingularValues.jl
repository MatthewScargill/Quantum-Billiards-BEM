using KrylovKit

# Krylov iteration based min svg approximator (25-50% speed gain)
function min_singular(A; v0=nothing, tol=TOL, krylovdim=100, maxiter=5000)
    if v0 === nothing # initial iteration
        min_svs, U, V, info = svdsolve(A, 1, :SR; tol=tol, krylovdim=krylovdim, maxiter=maxiter)
    else # further iteration using hot loop v0
        min_svs, U, V, info = svdsolve(A, v0, 1, :SR; tol=tol, krylovdim=krylovdim, maxiter=maxiter)
    end
    return min_svs[1], U[1]
end

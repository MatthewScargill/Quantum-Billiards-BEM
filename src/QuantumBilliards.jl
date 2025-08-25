module QuantumBilliards

# BEM functions
include("BEM/Mesh/Cardioid.jl")
include("BEM/Mesh/Circle.jl")
include("BEM/Mesh/Rectangle.jl")
include("BEM/Mesh/Square.jl")

include("BEM/GreenKernel.jl")
include("BEM/Matrix.jl")
include("BEM/Resonances.jl")


# FredholmComp functions
include("Spectral/Unfolding.jl")
include("Spectral/WDStats.jl")

# --- Visualisation ---

# Bring submodules into scope so users can access them
using .Mesh, .Kernels, .Assembly, .Solvers, .Resonances
using .Unfolding, .WDStats, .GoodnessOfFit
using .Fields, .SpectraPlots

end
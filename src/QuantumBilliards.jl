module QuantumBilliards

# Mesh files
include("BEM/Mesh/Cardioid.jl")
include("BEM/Mesh/Circle.jl")
include("BEM/Mesh/Rectangle.jl")
include("BEM/Mesh/Square.jl")

# BEM functions
include("BEM/GreenKernel.jl")
include("BEM/Matrix.jl")
include("BEM/Resonances.jl")
include("BEM/Solver.jl")

# Spectral functions
include("Spectral/Unfolding.jl")
include("Spectral/WDStats.jl")

# Visualisation functions
include("Visualisation/BoundaryVis.jl")
include("Visualisation/BilliardVis.jl")
include("Visualisation/ResVis.jl")
include("Visualisation/WDStatsvis.jl")


export cardioid_info, circle_info, rect_info, square_info
export kernel_bem, build_BEM_matrix, resonant_modes
export plot_boundary, plot_billiard

end
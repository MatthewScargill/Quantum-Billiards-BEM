module QuantumBilliards

using LinearAlgebra
using SpecialFunctions   # for Hankel functions 
using StaticArrays
using Base.Threads
using Plots
using StatsBase


const TOL = 1e-14

# Mesh files
include("BEM/Mesh/Cardioid.jl")
include("BEM/Mesh/Circle.jl")
include("BEM/Mesh/Rectangle.jl")
include("BEM/Mesh/Square.jl")
include("BEM/Mesh/Stadium.jl")

# BEM functions
include("BEM/Hankel.jl") # has to be first as contains HankelTable type
include("BEM/Kernel.jl")
include("BEM/Matrix.jl")
include("BEM/Resonances.jl")
include("BEM/Solver.jl")

# Spectral functions
include("Spectral/Weyl.jl")
include("Spectral/WignerDyson.jl")

# Visualisation functions
include("Visualisation/BoundaryVis.jl")
include("Visualisation/BilliardVis.jl")
include("Visualisation/SpacingVis.jl")
include("Visualisation/WeylComp.jl")


export TOL
export cardioid_info, circle_info, rect_info, square_info, stadium_info
export kernel_bem, build_BEM_matrix, resonant_modes, tabulate_hankel, HankelTable
export weyl_convert, weyl_unfold, weyl_count
export plot_boundary, plot_billiard, plot_weylcomp, plot_unfolded_spacings

end
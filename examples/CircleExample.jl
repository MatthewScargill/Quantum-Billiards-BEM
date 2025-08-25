import Pkg; Pkg.activate(joinpath(@__DIR__, "..")); Pkg.instantiate()

# Load the top-level module (brings in everything in src/)
include(joinpath(@__DIR__, "..", "src", "QuantumBilliards.jl"))

using .QuantumBilliards
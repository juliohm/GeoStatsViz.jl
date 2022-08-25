# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

module GeoStatsViz

using Meshes
using GeoStatsBase
using Variography

using Distances
using Reexport

import Makie

@reexport using MeshViz

include("weights.jl")
include("histograms.jl")
include("ensemble.jl")
include("problems.jl")
include("hscatter.jl")

end

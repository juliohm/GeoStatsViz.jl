# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

module GeoStatsViz

using GeoStatsBase
using Variography

using Reexport

import Makie

@reexport using MeshViz

include("weights.jl")
include("histograms.jl")
include("ensemble.jl")
include("problems.jl")

end

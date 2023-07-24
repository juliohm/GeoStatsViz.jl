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

# GeoStatsBase.jl recipes
include("base/weights.jl")
include("base/problems.jl")
include("base/histograms.jl")

# Variography.jl recipes
include("variography/empirical.jl")
include("variography/theoretical.jl")

# miscellaneous recipes
include("hscatter.jl")

end

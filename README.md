# GeoStatsViz.jl

[![Build Status](https://github.com/juliohm/GeoStatsViz.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/juliohm/GeoStatsViz.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/juliohm/GeoStatsViz.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/juliohm/GeoStatsViz.jl)

Makie.jl recipes for visualization of [GeoStats.jl](https://github.com/JuliaEarth/GeoStats.jl) objects.

## Usage

Any object defined in the GeoStats.jl framework can be visualized with
the `viz` function. Additionally, we provide other recipes such as
`hscatter` with custom signatures described in their docstrings.

```julia
using GeoStats, GeoStatsViz

# choose a Makie backend
import GLMakie as Mke

g = GaussianVariogram()

viz(g)
```
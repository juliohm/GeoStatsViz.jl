# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::GeoWeights) = Viz{<:Tuple{GeoWeights}}

function Makie.plot!(plot::Viz{<:Tuple{GeoWeights}})
  # retrieve weights object
  weights = plot[:object][]

  viz!(plot, domain(weights),
    size          = plot[:size],
    color         = collect(weights),
    alpha         = plot[:alpha],
    colorscheme   = plot[:colorscheme],
    facetcolor    = plot[:facetcolor],
    showfacets    = plot[:showfacets],
  )
end

# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::GeoWeights) = Viz{<:Tuple{GeoWeights}}

function Makie.plot!(plot::Viz{<:Tuple{GeoWeights}})
  # retrieve weights object
  weights = plot[:object]

  # underlying domain and values
  wdomain = Makie.@lift domain($weights)
  wvalues = Makie.@lift collect($weights)

  viz!(plot, wdomain,
    color       = wvalues,
    alpha       = plot[:alpha],
    colorscheme = plot[:colorscheme],
    facetcolor  = plot[:facetcolor],
    showfacets  = plot[:showfacets],
    pointsize   = plot[:pointsize],
    segmentsize = plot[:segmentsize]
  )
end

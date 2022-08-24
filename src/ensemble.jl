# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::Ensemble) = Viz{<:Tuple{Ensemble}}

function Makie.plot!(plot::Viz{<:Tuple{Ensemble}})
  # retrieve ensemble and variable
  ensemble = plot[:object][]
  variable = plot[:variable][]

  for real in ensemble
    viz!(plot, real, variable = variable,
      size          = plot[:size],
      alpha         = plot[:alpha][],
      colorscheme   = plot[:colorscheme],
      boundarycolor = plot[:boundarycolor],
      facetcolor    = plot[:facetcolor],
      showboundary  = plot[:showboundary],
      showfacets    = plot[:showfacets],
      decimation    = plot[:decimation],
    )
  end
end
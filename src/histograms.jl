# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::EmpiricalHistogram) = Viz{<:Tuple{EmpiricalHistogram}}

function Makie.plot!(plot::Viz{<:Tuple{EmpiricalHistogram}})
  # retrieve histogram object
  hist = plot[:object][]

  # abscissa and ordinates
  xs, ys = values(hist)

  Makie.barplot!(plot, xs, ys,
    color       = plot[:color],
    strokecolor = plot[:facetcolor],
    strokewidth = 0.1,
    gap         = 0.0,
  )
end
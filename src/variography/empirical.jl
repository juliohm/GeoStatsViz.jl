# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::EmpiricalVariogram) = Viz{<:Tuple{EmpiricalVariogram}}

function Makie.plot!(plot::Viz{<:Tuple{EmpiricalVariogram}})
  # retrieve variogram object
  γ = plot[:object][]

  # get the data
  x, y, n = values(γ)

  binsize = x[2] - x[1]

  # discard empty bins
  x = x[n .> 0]; y = y[n .> 0]; n = n[n .> 0]

  # visualize variogram
  Makie.scatterlines!(plot, x, y,
    color = plot[:color],
    markersize = plot[:pointsize],
  )

  # visualize bin counts
  Makie.text!(plot, string.(n),
    position = collect(zip(x, y)),
    textsize = plot[:pointsize],
  )

  # visualize frequencies as bars
  f = n*(maximum(y) / maximum(n)) / 10
  Makie.barplot!(plot, x, f,
    color       = plot[:color],
    strokecolor = plot[:facetcolor],
    strokewidth = 0.1,
    gap         = 0.0,
  )
end
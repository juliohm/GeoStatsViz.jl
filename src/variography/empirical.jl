# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::EmpiricalVariogram) = Viz{<:Tuple{EmpiricalVariogram}}

function Makie.plot!(plot::Viz{<:Tuple{EmpiricalVariogram}})
  # retrieve variogram object
  γ = plot[:object]

  # get the data
  xyn = Makie.@lift values($γ)
  x = Makie.@lift $xyn[1]
  y = Makie.@lift $xyn[2]
  n = Makie.@lift $xyn[3]

  # discard empty bins
  x = Makie.@lift $x[$n .> 0]
  y = Makie.@lift $y[$n .> 0]
  n = Makie.@lift $n[$n .> 0]

  # visualize variogram
  Makie.scatterlines!(plot, x, y,
    color = plot[:color],
    markersize = plot[:pointsize],
  )

  # visualize bin counts
  bincounts = Makie.@lift string.($n)
  positions = Makie.@lift collect(zip($x, $y))
  Makie.text!(plot, bincounts,
    position = positions,
    textsize = plot[:pointsize],
  )

  # visualize frequencies as bars
  f = Makie.@lift $n*(maximum($y) / maximum($n)) / 10
  Makie.barplot!(plot, x, f,
    color       = plot[:color],
    strokecolor = plot[:facetcolor],
    strokewidth = 0.1,
    gap         = 0.0,
  )
end
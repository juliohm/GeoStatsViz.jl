# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::Variogram) = Viz{<:Tuple{Variogram}}

function Makie.plot!(plot::Viz{<:Tuple{Variogram}})
  # retrieve variogram object
  γ = plot[:object]

  # start at 1e-6 instead of 0 to avoid
  # nugget artifact in visualization
  x = Makie.@lift range(1e-6, stop=_maxlag($γ), length=100)
  y = Makie.@lift $γ.($x)

  # visualize variogram
  Makie.lines!(plot, x, y,
    color = plot[:color],
  )
end

_maxlag(γ::Variogram)      = 3range(γ)
_maxlag(γ::PowerVariogram) = 3.0
_maxlag(γ::NuggetEffect)   = 3.0
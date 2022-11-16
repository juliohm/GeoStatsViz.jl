# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

"""
    hscatter(data, var₁, var₂)

H-scatter plot of geospatial `data` for pair of variables
`var₁` and `var₂` with additional options:

* `lag`           - lag distance between points (default to `0.0`)
* `tol`           - tolerance for lag distance (default to `1e-1`)
* `distance`      - distance from Distances.jl (default to `Euclidean()`)

Aesthetics options:

* `size`          - size of points in point set
* `color`         - color of geometries or points
* `alpha`         - transparency channel in [0,1]
* `colorscheme`   - color scheme from ColorSchemes.jl
* `rcolor`        - color of regression line
* `icolor`        - color of identity line
* `ccolor`        - color of center lines

## Examples

```
# h-scatter of Z vs. Z at lag 1.0
hscatter(data, :Z, :Z, lag=1.0)

# h-scatter of Z vs. W at lag 2.0
hscatter(data, :Z, :W, lag=2.0)
```
"""
@Makie.recipe(HScatter, data, var₁, var₂) do scene
  Makie.Attributes(;
    # h-scatter options
    lag           = 0.0,
    tol           = 1e-1,
    distance      = Euclidean(),

    # aesthetics options
    size          = Makie.theme(scene, :markersize),
    color         = :slategray3,
    alpha         = 1.0,
    colorscheme   = :viridis,
    rcolor        = :brown,
    icolor        = :black,
    ccolor        = :green,
  )
end

function Makie.plot!(plot::HScatter)
  # retrieve data and variables
  data = plot[:data][]
  var₁ = plot[:var₁][]
  var₂ = plot[:var₂][]

  # retrieve h-scatter options
  lag      = plot[:lag][]
  tol      = plot[:tol][]
  distance = plot[:distance][]

  # retrieve aesthetics options
  size        = plot[:size][]
  color       = plot[:color][]
  alpha       = plot[:alpha][]
  colorscheme = plot[:colorscheme][]
  rcolor      = plot[:rcolor][]
  icolor      = plot[:icolor][]
  ccolor      = plot[:ccolor][]

  # process color spec into colorant
  colorant = MeshViz.process(color, colorscheme, alpha)

  # lookup valid data
  I₁ = findall(!ismissing, getproperty(data, var₁))
  I₂ = findall(!ismissing, getproperty(data, var₂))
  𝒮₁ = view(data, I₁)
  𝒮₂ = view(data, I₂)
  𝒟₁ = domain(𝒮₁)
  𝒟₂ = domain(𝒮₂)
  X₁ = [coordinates(centroid(𝒟₁, i)) for i in 1:nelements(𝒟₁)]
  X₂ = [coordinates(centroid(𝒟₂, i)) for i in 1:nelements(𝒟₂)]
  z₁ = getproperty(𝒮₁, var₁)
  z₂ = getproperty(𝒮₂, var₂)

  # compute pairwise distance
  m, n = length(z₁), length(z₂)
  pairs = [(i,j) for j in 1:n for i in j:m]
  ds = [evaluate(distance, X₁[i], X₂[j]) for (i,j) in pairs]

  # find indices with given lag
  match = findall(abs.(ds .- lag) .< tol)

  if isempty(match)
    throw(ErrorException("no points were found with lag = $lag, aborting..."))
  end

  # visualize h-scatter
  mpairs = view(pairs, match)
  x = z₁[first.(mpairs)]
  y = z₂[last.(mpairs)]
  Makie.scatter!(plot, x, y,
    color      = colorant,
    markersize = size,
  )

  # visualize regression line
  X = [x ones(length(x))]
  ŷ = X * (X \ y)
  Makie.lines!(plot, x, ŷ,
    color = rcolor,
  )

  # visualize identity line
  xmin, xmax = extrema(x)
  ymin, ymax = extrema(y)
  vmin = min(xmin, ymin)
  vmax = max(xmax, ymax)
  Makie.lines!(plot, [vmin, vmax], [vmin, vmax],
    color = icolor,
  )

  # visualize center lines
  x̄, ȳ = mean(x), mean(y)
  Makie.lines!(plot, [x̄, x̄], [vmin, vmax],
    color = ccolor,
  )
  Makie.lines!(plot, [vmin, vmax], [ȳ, ȳ],
    color = ccolor,
  )
  Makie.scatter!(plot, [x̄], [ȳ],
    color = ccolor,
    marker = :rect,
    markersize  = 16,
  )
end
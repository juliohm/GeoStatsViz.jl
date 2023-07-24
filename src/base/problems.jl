# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::EstimationProblem) = Viz{<:Tuple{EstimationProblem}}

function Makie.plot!(plot::Viz{<:Tuple{EstimationProblem}})
  # retrieve problem object
  problem = plot[:object]

  # data and domain
  dom1 = Makie.@lift domain($problem)
  dom2 = Makie.@lift domain(data($problem))

  # visualize estimation domain
  viz!(plot, dom1,
    color       = plot[:color],
    alpha       = plot[:alpha],
    colorscheme = plot[:colorscheme],
    facetcolor  = plot[:facetcolor],
    showfacets  = plot[:showfacets],
    pointsize   = plot[:pointsize],
    segmentsize = plot[:segmentsize]
  )

  # visualize domain of data
  viz!(plot, dom2,
    color       = :black,
    alpha       = plot[:alpha],
    facetcolor  = plot[:facetcolor],
    showfacets  = plot[:showfacets],
    pointsize   = plot[:pointsize],
    segmentsize = plot[:segmentsize]
  )
end

Makie.plottype(::SimulationProblem) = Viz{<:Tuple{SimulationProblem}}

function Makie.plot!(plot::Viz{<:Tuple{SimulationProblem}})
  # retrieve problem object
  problem = plot[:object]

  # data and domain
  dom1 = Makie.@lift domain($problem)

  # visualize estimation domain
  viz!(plot, dom1,
    color       = plot[:color],
    alpha       = plot[:alpha],
    colorscheme = plot[:colorscheme],
    facetcolor  = plot[:facetcolor],
    showfacets  = plot[:showfacets],
    pointsize   = plot[:pointsize],
    segmentsize = plot[:segmentsize]
  )

  # visualize domain of data
  if hasdata(problem[])
    dom2 = Makie.@lift domain(data($problem))
    viz!(plot, dom2,
      color       = :black,
      alpha       = plot[:alpha],
      facetcolor  = plot[:facetcolor],
      showfacets  = plot[:showfacets],
      pointsize   = plot[:pointsize],
      segmentsize = plot[:segmentsize]
    )
  end
end

Makie.plottype(::LearningProblem) = Viz{<:Tuple{LearningProblem}}

function Makie.plot!(plot::Viz{<:Tuple{LearningProblem}})
  # retrieve problem object
  problem = plot[:object]

  # source and target domain
  dom1 = Makie.@lift domain(sourcedata($problem))
  dom2 = Makie.@lift domain(targetdata($problem))

  # visualize estimation domain
  viz!(plot, dom1,
    color       = plot[:color],
    alpha       = plot[:alpha],
    colorscheme = plot[:colorscheme],
    facetcolor  = plot[:facetcolor],
    showfacets  = plot[:showfacets],
    pointsize   = plot[:pointsize],
    segmentsize = plot[:segmentsize]
  )

  # visualize domain of data
  viz!(plot, dom2,
    color       = :gray90,
    alpha       = plot[:alpha],
    facetcolor  = plot[:facetcolor],
    showfacets  = plot[:showfacets],
    pointsize   = plot[:pointsize],
    segmentsize = plot[:segmentsize]
  )
end
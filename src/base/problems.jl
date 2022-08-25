# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::EstimationProblem) = Viz{<:Tuple{EstimationProblem}}

function Makie.plot!(plot::Viz{<:Tuple{EstimationProblem}})
  # retrieve problem object
  problem = plot[:object][]

  # data and domain
  pdata   = data(problem)
  pdomain = domain(problem)

  # visualize domain of data
  viz!(plot, domain(pdata), color = :olive)

  # visualize estimation domain
  viz!(plot, pdomain, alpha = 0.2)
end

Makie.plottype(::SimulationProblem) = Viz{<:Tuple{SimulationProblem}}

function Makie.plot!(plot::Viz{<:Tuple{SimulationProblem}})
  # retrieve problem object
  problem = plot[:object][]

  # data and domain
  pdata   = data(problem)
  pdomain = domain(problem)

  # visualize domain of data
  hasdata(problem) && viz!(plot, domain(pdata), color = :olive)

  # visualize simulation domain
  viz!(plot, pdomain, alpha = 0.2)
end

Makie.plottype(::LearningProblem) = Viz{<:Tuple{LearningProblem}}

function Makie.plot!(plot::Viz{<:Tuple{LearningProblem}})
  # retrieve problem object
  problem = plot[:object][]

  # source and target domain
  sdomain = domain(sourcedata(problem))
  tdomain = domain(targetdata(problem))

  # visualize source domain
  viz!(plot, sdomain)

  # visualize target domain
  viz!(plot, tdomain, alpha = 0.2)
end
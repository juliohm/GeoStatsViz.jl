# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENCE in the project root.
# ------------------------------------------------------------------

Makie.plottype(::GeoWeights) = Viz

function Makie.convert_arguments(P::Type{<:Viz}, w::GeoWeights) 
  dom = Makie.convert_arguments(P, domain(w))
  Makie.PlotSpec{Viz}(dom...; color = collect(w))
end
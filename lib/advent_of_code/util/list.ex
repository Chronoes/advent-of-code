defmodule AdventOfCode.Util.List do
  @spec transpose([[...]]) :: [[...]]
  def transpose([[] | _]), do: []

  def transpose(m), do: [Enum.map(m, &hd/1) | transpose(Enum.map(m, &tl/1))]
end

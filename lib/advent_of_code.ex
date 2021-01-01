defmodule AdventOfCode do
  @moduledoc """
  Documentation for AdventOfCode.
  """

  def get_current_year(%{year: year, month: month}) when month != 12, do: year - 1
  def get_current_year(%{year: year}), do: year
  def get_current_year(), do: get_current_year(Date.utc_today())
end

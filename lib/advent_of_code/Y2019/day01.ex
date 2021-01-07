defmodule AdventOfCode.Y2019.Day01 do
  @moduledoc "
  https://adventofcode.com/2019/day/1
  "

  @spec solve(:first | :second, any) :: any
  def solve(part \\ :first, input \\ nil)

  def solve(part, input) when is_nil(input) do
    solve(part, read_input())
  end

  def solve(:first, input) do
    input |> Enum.map(&required_fuel/1) |> Enum.sum()
  end

  def solve(:second, input) do
    input
    |> Enum.map(&required_fuel/1)
    |> Enum.map(&required_fuel_complete(&1, 0))
    |> Enum.sum()
  end

  def required_fuel(mass) when mass > 0 do
    Integer.floor_div(mass, 3) - 2
  end

  def required_fuel(_mass), do: 0

  def required_fuel_complete(mass, total) when mass > 0 do
    required_fuel_complete(required_fuel(mass), mass + total)
  end

  def required_fuel_complete(_mass, total), do: total

  defp read_input do
    File.read!("priv/inputs/Y2019/day01.txt")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end

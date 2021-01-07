defmodule AdventOfCode.Y2020.Day06 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/6
  """

  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&MapSet.new/1)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(&get_common_answers/1)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sum()
  end

  def get_common_answers(answers) do
    answers
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection(&1, &2))
  end

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day06.txt")
  end
end

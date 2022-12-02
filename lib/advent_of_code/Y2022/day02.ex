defmodule AdventOfCode.Y2022.Day02 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/2
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  def calculate_score("A X"), do: 1 + 3
  def calculate_score("A Y"), do: 2 + 6
  def calculate_score("A Z"), do: 3
  def calculate_score("B X"), do: 1
  def calculate_score("B Y"), do: 2 + 3
  def calculate_score("B Z"), do: 3 + 6
  def calculate_score("C X"), do: 1 + 6
  def calculate_score("C Y"), do: 2
  def calculate_score("C Z"), do: 3 + 3

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.map(&choose_shape/1)
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  def choose_shape("A X"), do: "A Z"
  def choose_shape("A Y"), do: "A X"
  def choose_shape("A Z"), do: "A Y"
  def choose_shape("B X"), do: "B X"
  def choose_shape("B Y"), do: "B Y"
  def choose_shape("B Z"), do: "B Z"
  def choose_shape("C X"), do: "C Y"
  def choose_shape("C Y"), do: "C Z"
  def choose_shape("C Z"), do: "C X"

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 2)
    content
  end
end

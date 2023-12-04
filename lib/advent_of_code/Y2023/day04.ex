defmodule AdventOfCode.Y2023.Day04 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/4
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, ": "))
    |> Enum.map(fn [_card, numbers] ->
      [winners, nrs] =
        String.split(numbers, " | ")
        |> Enum.map(&String.split/1)
        |> Enum.map(&MapSet.new/1)

      MapSet.intersection(winners, nrs)
      |> MapSet.size()
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(fn
      0 ->
        0

      winning_nrs ->
        2 ** (winning_nrs - 1)
    end)
    |> Enum.sum()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    cards = prep_input(input) |> Enum.with_index()
    calculate_sum(cards) + length(cards)
  end

  defp calculate_sum(cards) do
    calculate_sum(cards, cards)
  end

  defp calculate_sum([], _cards) do
    0
  end

  defp calculate_sum([{value, card} | rest], cards) do
    card_copies = Enum.slice(cards, card + 1, value)
    value + calculate_sum(card_copies, cards) + calculate_sum(rest, cards)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 4)
    content
  end
end

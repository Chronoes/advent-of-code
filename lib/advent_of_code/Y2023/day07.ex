defmodule AdventOfCode.Y2023.Day07 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/7
  """

  @ranks [
    :high_card,
    :one_pair,
    :two_pair,
    :three_of_a_kind,
    :full_house,
    :four_of_a_kind,
    :five_of_a_kind
  ]

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [cards, bid] = String.split(line)
      {String.to_charlist(cards), String.to_integer(bid)}
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(fn {hand, bid} ->
      {hand, bid, determine_hand(hand)}
    end)
    |> calc_ranks_and_sum()
  end

  defp get_card_value(card) when card in ?2..?9, do: card - ?0
  defp get_card_value(?T), do: 10
  defp get_card_value(?J), do: 11
  defp get_card_value(?Q), do: 12
  defp get_card_value(?K), do: 13
  defp get_card_value(?A), do: 14

  defp compare_hands([], []), do: nil
  defp compare_hands([head | hand1], [head | hand2]), do: compare_hands(hand1, hand2)

  defp compare_hands([head1 | _], [head2 | _]) do
    get_card_value(head1) < get_card_value(head2)
  end

  defp get_rank_value(rank) do
    Enum.find_index(@ranks, &(&1 == rank))
  end

  defp determine_hand(hand) do
    determine_hand(hand, {:high_card, []})
  end

  defp determine_hand([], type), do: type

  defp determine_hand([head | hand], {rank, values} = type) do
    result =
      case Enum.count(hand, &(&1 == head)) do
        0 -> :high_card
        1 -> :one_pair
        2 -> :three_of_a_kind
        3 -> :four_of_a_kind
        4 -> :five_of_a_kind
      end

    result_value = get_rank_value(result)
    rank_value = get_rank_value(rank)

    cond do
      result == :one_pair and rank == :one_pair ->
        determine_hand(hand, {:two_pair, [head | values]})

      result_value > rank_value ->
        case result do
          :one_pair ->
            determine_hand(hand, {:one_pair, [head]})

          :three_of_a_kind ->
            case rank do
              :one_pair -> determine_hand(hand, {:full_house, [head | values]})
              _ -> determine_hand(hand, {:three_of_a_kind, [head]})
            end

          :four_of_a_kind ->
            determine_hand(hand, {:four_of_a_kind, [head]})

          :five_of_a_kind ->
            determine_hand(hand, {:five_of_a_kind, [head]})
        end

      result == :one_pair and rank == :three_of_a_kind and head not in values ->
        determine_hand(hand, {:full_house, [head | values]})

      true ->
        determine_hand(hand, type)
    end
  end

  def calc_ranks_and_sum(results) do
    results
    |> Enum.sort(fn {hand1, _, {rank1, _}}, {hand2, _, {rank2, _}} ->
      rank1_value = get_rank_value(rank1)
      rank2_value = get_rank_value(rank2)

      if rank1_value == rank2_value do
        compare_hands(hand1, hand2)
      else
        rank1_value < rank2_value
      end
    end)
    # |> Enum.map(&IO.inspect/1)
    |> Enum.map(&elem(&1, 1))
    |> Enum.with_index(1)
    |> Enum.map(fn {bid, index} -> bid * index end)
    |> Enum.sum()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.map(fn {hand, bid} ->
      {rank, values} = determine_hand(hand)

      if ?J in values do
      else
      end

      {hand, bid, {rank, values}}
    end)
    |> calc_ranks_and_sum()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 7)
    content
  end
end

defmodule AdventOfCode.Y2020.Day08 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/8
  """

  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn [action, value] -> {action, String.to_integer(value)} end)
    |> Enum.with_index()
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> get_acc_value_on_loop()
    |> elem(0)
  end

  def get_acc_value_on_loop(instructions) do
    get_acc_value_on_loop(instructions, instructions, [], 0)
  end

  defp get_acc_value_on_loop(instructions, [head | tail], visited, acc) do
    {{action, value}, index} = head

    if Enum.member?(visited, index) do
      {acc, head, visited}
    else
      visited = [index | visited]

      case action do
        "nop" ->
          get_acc_value_on_loop(instructions, tail, visited, acc)

        "acc" ->
          get_acc_value_on_loop(instructions, tail, visited, acc + value)

        "jmp" ->
          next_instructions = Enum.drop(instructions, index + value)
          get_acc_value_on_loop(instructions, next_instructions, visited, acc)
      end
    end
  end

  defp get_acc_value_on_loop(_instructions, [], visited, acc), do: {acc, nil, visited}

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    instructions = prep_input(input)
    {acc, _last, visited} = get_acc_value_on_loop(instructions)
    retrace_and_retry(instructions, visited, acc)
  end

  def retrace_and_retry(instructions, [index | tail], acc) do
    {{action, value}, index} = Enum.at(instructions, index)

    rerun_loop = fn new_instructions ->
      case get_acc_value_on_loop(new_instructions) do
        {acc, nil, _} -> acc
        {acc, _, _} -> retrace_and_retry(instructions, tail, acc)
      end
    end

    case action do
      "nop" ->
        List.replace_at(instructions, index, {{"jmp", value}, index})
        |> rerun_loop.()

      "jmp" ->
        List.replace_at(instructions, index, {{"nop", value}, index})
        |> rerun_loop.()

      _ ->
        retrace_and_retry(instructions, tail, acc - value)
    end
  end

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day08.txt")
  end
end

defmodule AdventOfCode.Y2023.Day08 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/8
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    [instructions, _ | tail] =
      input
      |> String.trim()
      |> String.split("\n")

    {String.to_charlist(instructions),
     Enum.map(tail, fn line ->
       [node, left_right] = String.split(line, " = ")

       [left, right] =
         left_right
         |> String.trim_leading("(")
         |> String.trim_trailing(")")
         |> String.split(", ")

       {node, {left, right}}
     end)
     |> Map.new()}
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    {instructions, nodes} = prep_input(input)
    simulate_movement(instructions, nodes)
  end

  defp get_next_instruction(instructions, step) do
    instructions |> Enum.at(rem(step, length(instructions)))
  end

  def simulate_movement(instructions, nodes),
    do: simulate_movement(instructions, nodes, {"AAA", 0}, false)

  defp simulate_movement(instructions, nodes, {active_node, step}, ends_with_z) do
    elem_index =
      case get_next_instruction(instructions, step) do
        ?L -> 0
        ?R -> 1
      end

    new_node = elem(nodes[active_node], elem_index)

    if new_node === "ZZZ" or (ends_with_z and String.ends_with?(new_node, "Z")) do
      step + 1
    else
      simulate_movement(
        instructions,
        nodes,
        {new_node, step + 1},
        ends_with_z
      )
    end
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    {instructions, nodes} = prep_input(input)

    Map.keys(nodes)
    |> Enum.filter(fn node -> String.ends_with?(node, "A") end)
    |> Enum.map(fn node -> simulate_movement(instructions, nodes, {node, 0}, true) end)
    |> Enum.reduce(&Math.lcm/2)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 8)
    content
  end
end

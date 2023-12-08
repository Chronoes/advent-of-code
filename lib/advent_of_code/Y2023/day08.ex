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

  def simulate_movement(instructions, nodes),
    do: simulate_movement(instructions, instructions, nodes, {"AAA", 0})

  defp simulate_movement(_instructions, _full_instructions, _nodes, {"ZZZ", step}), do: step

  defp simulate_movement(instructions, full_instructions, nodes, {active_node, step}) do
    [inst | tail] = instructions

    elem_index =
      case inst do
        ?L -> 0
        ?R -> 1
      end

    simulate_movement(
      if(tail == [], do: full_instructions, else: tail),
      full_instructions,
      nodes,
      {elem(nodes[active_node], elem_index), step + 1}
    )
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    {instructions, nodes} = prep_input(input)
    simulate_simultaneous_movement(instructions, nodes)
  end

  defp simulate_simultaneous_movement(instructions, nodes),
    do:
      simulate_simultaneous_movement(
        instructions,
        instructions,
        {nodes,
         Map.keys(nodes)
         |> Enum.filter(fn node -> String.ends_with?(node, "Z") end)
         |> MapSet.new()},
        {Map.keys(nodes)
         |> Enum.filter(fn node -> String.ends_with?(node, "A") end), 0}
      )

  defp simulate_simultaneous_movement(
         instructions,
         full_instructions,
         {nodes, end_nodes},
         {active_nodes, step}
       ) do
    if rem(step, 1000) == 0 do
      IO.puts("#{active_nodes} Step #{step}")
    end

    if Enum.all?(active_nodes, &MapSet.member?(end_nodes, &1)) do
      step
    else
      [inst | tail] = instructions

      elem_index =
        case inst do
          ?L -> 0
          ?R -> 1
        end

      simulate_simultaneous_movement(
        if(tail == [], do: full_instructions, else: tail),
        full_instructions,
        {nodes, end_nodes},
        {
          Enum.map(active_nodes, fn active_node -> elem(nodes[active_node], elem_index) end),
          step + 1
        }
      )
    end
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 8)
    content
  end
end

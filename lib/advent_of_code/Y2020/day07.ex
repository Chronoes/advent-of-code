defmodule AdventOfCode.Y2020.Day07 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/7
  """

  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce(Graph.new(type: :directed), &populate_graph/2)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Graph.reaching_neighbors(["shiny gold"])
    |> length()
  end

  def populate_graph(line, graph) do
    [container_bag_color, remaining] = String.split(line, " bags contain ", trim: true)

    graph = Graph.add_vertex(graph, container_bag_color)

    if remaining != "no other bags." do
      String.split(remaining, ",", trim: true)
      |> Enum.map(&Regex.run(~r/([0-9]) ([a-z ]+) bags?/, &1))
      |> Enum.reduce(graph, fn [_, bag_count, inner_bag_color], g ->
        Graph.add_edge(g, container_bag_color, inner_bag_color,
          weight: String.to_integer(bag_count)
        )
      end)
    else
      graph
    end
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> count_all_bags("shiny gold")
  end

  def count_all_bags(graph, start_color) do
    calc_accumulated_weights(graph, Graph.out_edges(graph, start_color)) - 1
  end

  def calc_accumulated_weights(graph, [head | tail]) do
    # Depth-first for bag multiplications e.g. 1 -> 3 -> 5 -> 2 == 3 * 5 * 2 * 1
    bags = head.weight * calc_accumulated_weights(graph, Graph.out_edges(graph, head.v2))
    # Sum other edges of the same vertex
    bags + calc_accumulated_weights(graph, tail)
  end

  def calc_accumulated_weights(_graph, []), do: 1

  @impl true
  def read_input do
    File.read!("priv/inputs/Y2020/day07.txt")
  end
end

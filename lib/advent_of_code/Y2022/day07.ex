defmodule AdventOfCode.Y2022.Day07 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/7
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.reduce(
      {Graph.new(type: :directed) |> Graph.add_vertex("/", [:dir]), ["/"]},
      &populate_graph/2
    )
    |> elem(0)
  end

  def dir_vertex(dir_list), do: dir_list |> Enum.reverse() |> Enum.join("/")

  def populate_graph("$ cd ..", {graph, current_dir}), do: {graph, tl(current_dir)}

  def populate_graph("$ cd " <> dir, {graph, current_dir}) do
    if dir !== hd(current_dir) do
      new_dir = [dir | current_dir]
      dir_v = dir_vertex(new_dir)
      graph = Graph.add_vertex(graph, dir_v, [:dir])
      graph = Graph.add_edge(graph, dir_vertex(current_dir), dir_v, weight: 0)
      {graph, new_dir}
    else
      {graph, current_dir}
    end
  end

  def populate_graph("$ ls", acc), do: acc

  def populate_graph("dir " <> dir, {graph, current_dir}) do
    dir_v = dir_vertex([dir | current_dir])
    graph = Graph.add_vertex(graph, dir_v, [:dir])
    graph = Graph.add_edge(graph, dir_vertex(current_dir), dir_v, weight: 0)
    {graph, current_dir}
  end

  def populate_graph(cmd, {graph, current_dir}) do
    {filesize, filename} = Integer.parse(cmd)
    filename = String.trim(filename)
    graph = Graph.add_edge(graph, dir_vertex(current_dir), filename, weight: filesize)
    {graph, current_dir}
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> find_dir_sizes()
    |> Map.values()
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def find_dir_sizes(graph), do: find_dir_sizes(graph, "/", %{})

  def find_dir_sizes(graph, vertex, size_map) do
    Graph.out_edges(graph, vertex)
    |> Enum.reduce(size_map, fn edge, acc ->
      # get current size of folder
      total_size = Map.get(acc, edge.v1, 0)
      # Find sizes for subfolders, DFS
      acc = find_dir_sizes(graph, edge.v2, acc)
      # Add sizes of subfolders and files to parent folder size
      Map.put(acc, edge.v1, total_size + edge.weight + Map.get(acc, edge.v2, 0))
    end)
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    dir_sizes =
      prep_input(input)
      |> find_dir_sizes()

    available_space = 70_000_000
    needed_space = 30_000_000
    target_space = abs(available_space - needed_space - dir_sizes["/"])

    Map.values(dir_sizes)
    |> Enum.filter(&(&1 >= target_space))
    |> Enum.min()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 7)
    content
  end
end

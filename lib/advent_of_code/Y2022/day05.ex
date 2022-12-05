defmodule AdventOfCode.Y2022.Day05 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2022/day/5
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    [crates, cmds | _] =
      input
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, "\n"))

    crates =
      crates
      |> Enum.reverse()
      |> tl()
      |> Enum.reverse()
      |> Enum.map(fn line ->
        line
        |> String.to_charlist()
        |> Enum.chunk_every(4)
        |> Enum.map(
          &Enum.filter(&1, fn
            c -> ?A <= c and c <= ?Z
          end)
        )
      end)

    max_len = Enum.map(crates, &length/1) |> Enum.max()

    crates =
      crates
      |> Enum.map(fn
        list when length(list) < max_len ->
          Enum.concat(list, List.duplicate('', max_len - length(list)))

        list ->
          list
      end)
      |> AdventOfCode.Util.List.transpose()
      |> Enum.map(
        &Enum.filter(&1, fn
          '' -> false
          _ -> true
        end)
      )

    {crates, cmds}
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    solve(input, true)
  end

  def run_cmds(crates, cmds, stack_like \\ false)
  def run_cmds(crates, [], _), do: crates

  def run_cmds(crates, ["" | cmds], stack_like), do: run_cmds(crates, cmds, stack_like)

  def run_cmds(crates, [cmd | cmds], stack_like) do
    [_ | tail] = Regex.run(~r/move (\d+) from (\d+) to (\d+)/, cmd)
    [nr, fr, to] = Enum.map(tail, fn n -> Integer.parse(n) |> elem(0) end)
    fr = fr - 1
    to = to - 1
    {fr_h, fr_t} = Enum.at(crates, fr) |> Enum.split(nr)

    fr_h = if stack_like, do: Enum.reverse(fr_h), else: fr_h

    crates
    |> List.replace_at(to, Enum.concat(fr_h, Enum.at(crates, to)))
    |> List.replace_at(fr, fr_t)
    |> run_cmds(cmds, stack_like)
  end

  def solve(input, stack_like) do
    {crates, cmds} = prep_input(input)

    run_cmds(crates, cmds, stack_like)
    |> Enum.map(&hd/1)
    |> Enum.concat()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    solve(input, false)
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2022, 5)
    content
  end
end

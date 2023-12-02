defmodule AdventOfCode.Y2023.Day02 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/2
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      ["Game " <> id, rest] = String.split(line, ":")

      {String.to_integer(id),
       rest
       |> String.trim()
       |> String.split(";")
       |> Enum.map(fn run ->
         run
         |> String.split(",")
         |> Enum.map(fn card ->
           [nr, color] =
             card
             |> String.trim()
             |> String.split(" ")

           {String.to_integer(nr), color}
         end)
       end)}
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    color_config = %{
      "red" => 12,
      "green" => 13,
      "blue" => 14
    }

    prep_input(input)
    |> Enum.filter(fn {_id, runs} ->
      Enum.all?(runs, fn run ->
        Enum.all?(run, fn {nr, color} ->
          nr <= color_config[color]
        end)
      end)
    end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> Enum.map(fn {_id, runs} ->
      Enum.reduce(
        runs,
        %{
          "red" => 0,
          "green" => 0,
          "blue" => 0
        },
        fn run, color_map ->
          Enum.reduce(
            run,
            color_map,
            fn {nr, color}, color_map ->
              Map.update(color_map, color, nr, &max(&1, nr))
            end
          )
        end
      )
    end)
    |> Enum.map(fn color_map ->
      Map.values(color_map)
      |> Enum.product()
    end)
    |> Enum.sum()
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 2)
    content
  end
end

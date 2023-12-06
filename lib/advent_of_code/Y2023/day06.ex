defmodule AdventOfCode.Y2023.Day06 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2023/day/6
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> tl()
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> Enum.map(fn line ->
      line
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
    |> Enum.map(&calculate_wins/1)
    |> Enum.product()
  end

  defp calculate_wins({time, distance}) do
    # let speed
    # remaining_time = time - speed
    # speed * remaining_time > distance
    # speed * (time - speed) > distance
    # -(speed ** 2) + time * speed - distance > 0
    # quadratic formula, solve for speed
    # speed = (-time +- :math.sqrt(time ** 2 - 4 * -1 * -distance)) / (2 * -1)
    # speed = (time +- :math.sqrt(time ** 2 - 4 * distance)) / 2
    discriminant_root = :math.sqrt(time ** 2 - 4 * distance)
    speed1 = (time - discriminant_root) / 2
    speed2 = (time + discriminant_root) / 2

    # initial formula is >0 when speed1 < speed < speed2
    # As we must use whole numbers, we do some rounding
    trunc(:math.ceil(speed2) - :math.floor(speed1)) - 1
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    [time, distance] =
      prep_input(input)
      |> Enum.map(fn line ->
        line
        |> Enum.join()
        |> String.to_integer()
      end)

    calculate_wins({time, distance})
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2023, 6)
    content
  end
end

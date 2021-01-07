defmodule AdventOfCode.Y2020.Day12 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2020/day/12
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn instr ->
      {instr, nr} = String.split_at(instr, 1)
      {instr, String.to_integer(nr)}
    end)
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    prep_input(input)
    |> move_ship({0, 0}, 90)
    |> manhattan_distance()
  end

  def manhattan_distance({x, y}), do: abs(x) + abs(y)

  def move_ship([{instr, nr} | tail], {x, y} = coords, direction) do
    case instr do
      "F" ->
        {east, north} =
          case direction do
            0 -> {0, 1}
            90 -> {1, 0}
            180 -> {0, -1}
            270 -> {-1, 0}
          end

        move_ship(tail, {x + east * nr, y + north * nr}, direction)

      "R" ->
        move_ship(tail, coords, rem(direction + nr + 360, 360))

      "L" ->
        move_ship(tail, coords, rem(direction - nr + 360, 360))

      "N" ->
        move_ship(tail, {x, y + nr}, direction)

      "S" ->
        move_ship(tail, {x, y - nr}, direction)

      "E" ->
        move_ship(tail, {x + nr, y}, direction)

      "W" ->
        move_ship(tail, {x - nr, y}, direction)
    end
  end

  def move_ship([], coords, _direction), do: coords

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    prep_input(input)
    |> move_ship_with_waypoint({10, 1}, {0, 0})
    |> manhattan_distance()
  end

  def move_ship_with_waypoint([{instr, nr} | tail], {wp_x, wp_y} = wp, coords) do
    case instr do
      "F" ->
        {x, y} = coords
        move_ship_with_waypoint(tail, wp, {x + wp_x * nr, y + wp_y * nr})

      "R" ->
        move_ship_with_waypoint(tail, rotate_point_by(wp, nr), coords)

      "L" ->
        move_ship_with_waypoint(tail, rotate_point_by(wp, -nr), coords)

      "N" ->
        move_ship_with_waypoint(tail, {wp_x, wp_y + nr}, coords)

      "S" ->
        move_ship_with_waypoint(tail, {wp_x, wp_y - nr}, coords)

      "E" ->
        move_ship_with_waypoint(tail, {wp_x + nr, wp_y}, coords)

      "W" ->
        move_ship_with_waypoint(tail, {wp_x - nr, wp_y}, coords)
    end
  end

  def move_ship_with_waypoint([], _wp, coords), do: coords

  defp rotate_point_by({x, y}, degrees) when degrees in [90, -270], do: {y, -x}
  defp rotate_point_by({x, y}, degrees) when abs(degrees) === 180, do: {-x, -y}
  defp rotate_point_by({x, y}, degrees) when degrees in [270, -90], do: {-y, x}

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2020, 12)
    content
  end
end

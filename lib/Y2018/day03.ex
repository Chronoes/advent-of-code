defmodule AdventOfCode.Y2018.Day03 do
  @input "289326"

  @rotations [{-1, 0}, {0, -1}, {1, 0}, {0, 1}]

  def solve(part, input \\ @input)

  def solve(:first, input) do
    number =
      input
      |> String.to_integer()

    level = calc_level(number)

    calc_distance(level, position(level, number))
  end

  def solve(:second, input) do
    input
  end

  def calc_distance(0, _position), do: 0
  def calc_distance(level, position), do: level + abs(position - level)

  def position(level, number), do: rem(calc_diagonal(level) - number, 2 * level)

  @doc """
  (2n + 1)^2 where n is the level number starting from 0. The result equals to bottom right diagonal value of given level
  """
  def calc_level(number), do: ((:math.sqrt(number) - 1) / 2) |> :math.ceil() |> trunc

  @doc """
  level |> calc_diagonal |> calc_level == level
  """
  def calc_diagonal(level), do: :math.pow(2 * level + 1, 2) |> trunc

  def generate_moves do
    Stream.unfold([move: 1, rotate: 1, move: 1, rotate: 1], fn [{:move, count} | _tail] ->
      {[move: count, rotate: 1, move: count, rotate: 1],
       [move: count + 1, rotate: 1, move: count + 1, rotate: 1]}
    end)
  end
end

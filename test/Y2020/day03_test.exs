defmodule AdventOfCode.Y2020.Day03Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day03, as: Solver

  @sample_input """
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  """

  test "first stage" do
    assert Solver.solve_first() == 211
  end

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) == 7
  end

  test "second stage" do
    assert Solver.solve_second() == 3_584_591_857
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) == 336
  end
end

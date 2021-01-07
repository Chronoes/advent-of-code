defmodule AdventOfCode.Y2020.Day11Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day11, as: Solver

  @sample_input """
  L.LL.LL.LL
  LLLLLLL.LL
  L.L.L..L..
  LLLL.LL.LL
  L.LL.LL.LL
  L.LLLLL.LL
  ..L.L.....
  LLLLLLLLLL
  L.LLLLLL.L
  L.LLLLL.LL
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 37
  end

  test "first stage" do
    assert Solver.solve_first() === 2249
  end

  @tag :skip
  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === true
  end

  @tag :skip
  test "second stage" do
    assert Solver.solve_second() === true
  end
end

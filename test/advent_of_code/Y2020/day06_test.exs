defmodule AdventOfCode.Y2020.Day06Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day06, as: Solver

  @sample_input """
  abc

  a
  b
  c

  ab
  ac

  a
  a
  a
  a

  b
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) == 11
  end

  test "first stage" do
    assert Solver.solve_first() == 6521
  end

  test "common answers" do
    assert Solver.get_common_answers(["abc", "bc"]) == MapSet.new(["b", "c"])
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) == 6
  end

  test "second stage" do
    assert Solver.solve_second() == 3305
  end
end

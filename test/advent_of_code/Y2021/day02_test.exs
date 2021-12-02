defmodule AdventOfCode.Y2021.Day02Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day02, as: Solver

  @sample_input """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 150
  end

  test "first stage" do
    assert Solver.solve_first() === 1_840_243
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 900
  end

  test "second stage" do
    assert Solver.solve_second() === 1_727_785_422
  end
end

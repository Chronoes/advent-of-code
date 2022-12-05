defmodule AdventOfCode.Y2022.Day05Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day05, as: Solver

  @sample_input """
      [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2

  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 'CMZ'
  end

  test "first stage" do
    assert Solver.solve_first() === 'TLNGFGMFN'
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 'MCD'
  end

  test "second stage" do
    assert Solver.solve_second() === 'FGLQJCMBD'
  end
end

defmodule AdventOfCode.Y2020.Day01Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day01, as: Solver

  test "first stage" do
    assert Solver.solve_first() == 1_014_171
  end

  test "first stage sample" do
    assert Solver.solve_first("""
           1721
           979
           366
           299
           675
           1456
           """) == 514_579
  end

  test "second stage" do
    assert Solver.solve_second() == 46_584_630
  end
end

defmodule AdventOfCode.Y2023.Day07Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2023.Day07, as: Solver

  @sample_input """
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  """

  test "first stage sample" do
    # TODO: Solve first sample
    assert Solver.solve_first(@sample_input) === 6440
  end

  test "first stage" do
    assert Solver.solve_first() === 252_295_678
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 5905
  end

  test "second stage" do
    assert Solver.solve_second() === 250_577_259
  end
end

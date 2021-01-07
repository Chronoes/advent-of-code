defmodule AdventOfCode.Y2020.Day05Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day05, as: Solver

  @sample_input """
  FBFBBFFRLR
  BFFFBBFRRR
  FFFBBBFRRR
  BBFFBBFRLL
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) == 820
  end

  test "seat ID of FBFBBFFRLR" do
    assert Solver.calc_seat_id("FBFBBFFRLR") == 357
  end

  test "seat ID of BFFFBBFRRR" do
    assert Solver.calc_seat_id("BFFFBBFRRR") == 567
  end

  test "seat ID of FFFBBBFRRR" do
    assert Solver.calc_seat_id("FFFBBBFRRR") == 119
  end

  test "seat ID of BBFFBBFRLL" do
    assert Solver.calc_seat_id("BBFFBBFRLL") == 820
  end

  test "first stage" do
    assert Solver.solve_first() == 913
  end

  test "second stage" do
    assert Solver.solve_second() == 717
  end
end

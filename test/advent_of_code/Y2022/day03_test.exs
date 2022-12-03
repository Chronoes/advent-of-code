defmodule AdventOfCode.Y2022.Day03Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day03, as: Solver

  @sample_input """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 157
  end

  test "first stage" do
    assert Solver.solve_first() === 8053
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 70
  end

  test "second stage" do
    assert Solver.solve_second() === 2425
  end
end

defmodule AdventOfCode.Y2020.Day07Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2020.Day07, as: Solver

  @sample_input """
  light red bags contain 1 bright white bag, 2 muted yellow bags.
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) == 4
  end

  test "first stage" do
    assert Solver.solve_first() == 246
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) == 32
  end

  test "second stage" do
    assert Solver.solve_second() == 2976
  end
end

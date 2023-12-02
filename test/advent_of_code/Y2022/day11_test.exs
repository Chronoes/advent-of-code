defmodule AdventOfCode.Y2022.Day11Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2022.Day11, as: Solver

  @sample_input """
  Monkey 0:
    Starting items: 79, 98
    Operation: new = old * 19
    Test: divisible by 23
      If true: throw to monkey 2
      If false: throw to monkey 3

  Monkey 1:
    Starting items: 54, 65, 75, 74
    Operation: new = old + 6
    Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

  Monkey 2:
    Starting items: 79, 60, 97
    Operation: new = old * old
    Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

  Monkey 3:
    Starting items: 74
    Operation: new = old + 3
    Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 10605
  end

  @tag :skip
  test "first stage" do
    assert Solver.solve_first() === true
  end

  @tag :skip
  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 2_713_310_158
  end

  @tag :skip
  test "second stage" do
    assert Solver.solve_second() === true
  end
end

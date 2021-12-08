defmodule AdventOfCode.Y2021.Day08Test do
  use ExUnit.Case, async: true
  alias AdventOfCode.Y2021.Day08, as: Solver

  @sample_input """
  acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf
  """

  @sample_input_large """
  be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
  edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
  fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
  fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
  aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
  fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
  dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
  bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
  egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
  gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
  """

  test "first stage sample" do
    assert Solver.solve_first(@sample_input) === 0
  end

  test "first stage large sample" do
    assert Solver.solve_first(@sample_input_large) === 26
  end

  test "first stage" do
    assert Solver.solve_first() === 247
  end

  test "second stage sample" do
    assert Solver.solve_second(@sample_input) === 5353
  end

  test "second stage large sample" do
    assert Solver.solve_second(@sample_input_large) === 61229
  end

  test "second stage" do
    assert Solver.solve_second() === 933_305
  end
end

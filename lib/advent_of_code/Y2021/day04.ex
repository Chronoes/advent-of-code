defmodule AdventOfCode.Y2021.Day04 do
  use AdventOfCode.Day

  @moduledoc """
  https://adventofcode.com/2021/day/4
  """

  @spec prep_input(any) :: any
  def prep_input(input) do
    [numbers | boards] =
      input
      |> String.trim()
      |> String.split("\n\n")

    {numbers |> String.split(",") |> Enum.map(&String.to_integer/1),
     boards
     |> Enum.map(fn board ->
       board
       |> String.split("\n")
       |> Enum.map(&String.split/1)
       |> Enum.map(&Enum.map(&1, fn nr -> {String.to_integer(nr), false} end))
     end)}
  end

  @impl true
  @spec solve_first(any) :: any
  def solve_first(input) do
    {numbers, boards} = prep_input(input)

    {board, draw} = find_winning_board(numbers, boards)
    draw * calculate_unmarked_sum(board)
  end

  def find_winning_board([draw | numbers], boards) do
    marked_boards = boards |> Enum.map(&mark_board(draw, &1))

    case Enum.filter(marked_boards, &is_winning_board?/1) do
      [] -> find_winning_board(numbers, marked_boards)
      [board] -> {board, draw}
    end
  end

  def mark_board(nr, board) do
    board
    |> Enum.map(fn rows ->
      Enum.map(rows, fn
        {board_nr, _marked} when board_nr == nr -> {board_nr, true}
        col -> col
      end)
    end)
  end

  def is_winning_board?(board),
    do:
      has_winning_rows?(board) ||
        List.zip(board) |> Enum.map(&Tuple.to_list/1) |> has_winning_rows?()

  defp has_winning_rows?(board),
    do: Enum.any?(board, fn rows -> Enum.all?(rows, fn {_nr, marked} -> marked end) end)

  def calculate_unmarked_sum(board) do
    Enum.map(board, fn rows ->
      Enum.map(
        rows,
        fn
          {nr, false} -> nr
          {_nr, true} -> 0
        end
      )
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  @impl true
  @spec solve_second(any) :: any
  def solve_second(input) do
    {numbers, boards} = prep_input(input)

    {board, draw} = find_last_board(numbers, boards)
    draw * calculate_unmarked_sum(board)
  end

  def find_last_board([draw | numbers], boards) do
    marked_boards = boards |> Enum.map(&mark_board(draw, &1))

    case Enum.reject(marked_boards, &is_winning_board?/1) do
      [board] ->
        find_winning_board(numbers, [board])

      remaining ->
        find_last_board(numbers, remaining)
    end
  end

  @impl true
  def read_input do
    {:ok, content} = AdventOfCodeHelper.get_input(2021, 4)
    content
  end
end

defmodule AdventOfCode.Y2019.Day02 do
  @moduledoc "
  https://adventofcode.com/2019/day/2
  "

  @spec solve(:first | :second, any) :: any
  def solve(part \\ :first, input \\ nil)

  def solve(part, input) when is_nil(input) do
    solve(part, read_input())
  end

  def solve(:first, input) do
    input |> List.replace_at(1, 12) |> List.replace_at(2, 2) |> read_instructions() |> hd()
  end

  def solve(:second, input) do
    input
  end

  @spec read_instructions([integer]) :: [integer]
  def read_instructions(program), do: read_instructions(program, 0)

  defp read_instructions(program, pointer) do
    action_result =
      program
      |> Enum.drop(pointer)
      |> run_instruction(program)

    case action_result do
      {:exit, program} -> program
      {:advance, length, program} -> read_instructions(program, pointer + length)
    end
  end

  @spec run_instruction([integer], [integer]) ::
          {:advance, non_neg_integer, [integer]} | {:exit, [integer]}
  def run_instruction([1 | rest], program) do
    {:advance, 4, run_instruction(Enum.take(rest, 3), program, &Kernel.+/2)}
  end

  def run_instruction([2 | rest], program) do
    {:advance, 4, run_instruction(Enum.take(rest, 3), program, &Kernel.*/2)}
  end

  def run_instruction([99 | _rest], program) do
    {:exit, program}
  end

  defp run_instruction([pos1, pos2, output], program, execute) do
    value1 = Enum.at(program, pos1)
    value2 = Enum.at(program, pos2)
    List.replace_at(program, output, execute.(value1, value2))
  end

  defp read_input do
    File.read!("priv/inputs/Y2019/day02.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end

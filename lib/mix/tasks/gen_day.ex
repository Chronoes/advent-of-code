defmodule Mix.Tasks.GenDay do
  use Mix.Task

  @shortdoc "Generate a day boilerplate"

  @template "priv/templates/day.eex"
  @test_template "priv/templates/day_test.eex"
  @inputs_folder "priv/inputs"
  @output "lib/"
  @test_folder "test/"

  def run([day]), do: run([day, to_string(Date.utc_today().year)])
  def run([day, year]), do: create_file(day, year)

  def run(_args) do
    today = Date.utc_today()
    run([to_string(today.day), to_string(today.year)])
  end

  defp create_file(day, year) do
    padded_day = String.pad_leading(day, 2, "0")
    year_name = "Y#{year}"

    input_path =
      @inputs_folder
      |> Path.join(year_name)
      |> Path.join("day" <> padded_day <> ".txt")

    assigns = [
      day: day,
      year: year,
      module: "#{year_name}.Day#{padded_day}",
      input_path: input_path
    ]

    # Create main solving file
    @output
    |> Path.join(year_name)
    |> Path.join("day" <> padded_day <> ".ex")
    |> Mix.Generator.create_file(EEx.eval_file(@template, assigns: assigns))

    # Create unit test file
    @test_folder
    |> Path.join(year_name)
    |> Path.join("day" <> padded_day <> "_test.exs")
    |> Mix.Generator.create_file(EEx.eval_file(@test_template, assigns: assigns))

    # Create empty input file
    Mix.Generator.create_file(input_path, "")
  end
end

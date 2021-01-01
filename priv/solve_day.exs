get_action = fn
  "f" <> _ ->
    :first

  "s" <> _ ->
    :second

  _ ->
    :all
end

today = Date.utc_today()

{action, day, year} =
  case System.argv() do
    [] ->
      {:all, to_string(today.day), AdventOfCode.get_current_year(today)}

    [a] ->
      {get_action.(a), to_string(today.day), AdventOfCode.get_current_year(today)}

    [a, day] ->
      {get_action.(a), day, AdventOfCode.get_current_year(today)}

    [a, day, year] ->
      {get_action.(a), day, year}

    _ ->
      raise "Invalid arguments"
  end

day = String.pad_leading(day, 2, "0")

module = Module.concat([AdventOfCode, "Y#{year}", "Day#{day}"])

IO.puts("Solve Day #{day} in #{year}")

run_action = fn
  :first ->
    IO.puts("First task answer:")
    IO.puts(module.solve_first())

  :second ->
    IO.puts("Second task answer:")
    IO.puts(module.solve_second())
end

if action == :all do
  run_action.(:first)
  run_action.(:second)
else
  run_action.(action)
end

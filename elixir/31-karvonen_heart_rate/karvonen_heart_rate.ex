Code.load_file("../util/input.ex")
Code.load_file("table_formatter.ex")

defmodule KarvonenHeartRate do
  import Input
  import TableFormatter

  def run do
    resting_hr = int_p("Resting Pulse: ")
    age = int_p("Age: ")

    print_table(age, resting_hr)
  end

  defp print_table(age, resting_hr) do
    intensities = numbers_list(55, 95, 5)

    intensities
    |> get_rates(age, resting_hr)
    |> build_rows(intensities)
    |> print_table_for_columns(["Intensity", "Rate"])
  end

  defp numbers_list(initial, final, interval) do
    Stream.iterate(initial, &(&1 + interval)) |> Enum.take_while(&(&1 <= final))
  end

  defp get_rates(intensities, age, resting_hr) do
    Enum.map(intensities, &target_heart_rate(age, resting_hr, &1))
  end

  defp build_rows(rates, intensities) do
    List.zip([intensities, rates])
    |> Enum.map(fn {i, r} ->
      %{"Intensity" => "#{i}%", "Rate" => "#{r} rpm"}
    end)
  end

  defp target_heart_rate(age, resting_hr, intensity) do
    round(((220 - age) - resting_hr) * (intensity / 100) + resting_hr)
  end
end

KarvonenHeartRate.run()

Code.load_file("../util/input.ex")

defmodule MonthNames do
  import Input

  def run do
    language = string("Enter your language: ") |> String.upcase

    month =
      int("Please enter the number of the month: ")
      |> validate_month

    month_name = languages()[String.to_atom(language)][month]

    IO.puts out(language, month_name)
  end

  defp validate_month(month) when month >= 1 and month <= 12, do: month
  defp validate_month(_), do: "The month is invalid."

  defp languages do
    %{
        EN: %{ 1 => "January", 2 => "February", 3 => "March", 4 => "April",
               5 => "May", 6 => "June", 7 => "July", 8 => "August",
               9 => "September", 10 => "October", 11 => "November", 12 => "December"
              },
        PT: %{ 1 => "Janeiro", 2 => "Fevereiro", 3 => "Março", 4 => "Abril",
               5 => "Maio", 6 => "Junho", 7 => "Julho", 8 => "Agosto",
               9 => "Setembro", 10 => "Outubro", 11 => "Novembro", 12 => "Dezembro"
              },
        AL: %{ 1 => "Januar", 2 => "Februar", 3 => "Marz", 4 => "April",
               5 => "Mai", 6 => "Juni", 7 => "Juli", 8 => "August",
               9 => "September", 10 => "Oktober", 11 => "November", 12 => "Dezember"
              },
        FR: %{ 1 => "Janvier", 2 => "Février", 3 => "Mars", 4 => "Avril",
               5 => "Mai", 6 => "Juin", 7 => "Juillet", 8 => "Août",
               9 => "Septembre", 10 => "Octobre", 11 => "Novembre", 12 => "Décembre"
              },
        IT: %{ 1 => "Gennaio", 2 => "Febbraio", 3 => "Marzo", 4 => "Aprile",
               5 => "Maggio", 6 => "Giugno", 7 => "Luglio", 8 => "Agosto",
               9 => "Settembre", 10 => "Ottobre", 11 => "Novembre", 12 => "Dicembre"
              },
        ES: %{ 1 => "Enero", 2 => "Febrero", 3 => "Marzo", 4 => "Abril",
               5 => "Mayo", 6 => "Junio", 7 => "Julio", 8 => "Agosto",
               9 => "Septiembre", 10 => "Octubre", 11 => "Noviembre", 12 => "Deciembre"
             }
    }
  end

  defp out("EN", month_name), do: "The name of the month is #{month_name}"
  defp out("PT", month_name), do: "O nome do mês é #{month_name}"
  defp out("AL", month_name), do: "Der Name des Monats ist #{month_name}"
  defp out("FR", month_name), do: "Le nom du mois est #{month_name}"
  defp out("IT", month_name), do: "Il nome del mese è #{month_name}"
  defp out("ES", month_name), do: "El nombre del mes es #{month_name}"
end

MonthNames.run()

defmodule OpenNotify do
  @moduledoc """
  Pulls in the data from the OpenNotify API about who is in space right now
  and displays this information in a tabular format.
  """

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "http://api.open-notify.org")
  plug(Tesla.Middleware.JSON)

  @doc """
  Retrieves and parses the data from the Open Notify API.

  ## Examples

      iex> response = OpenNotify.people_in_space()
      iex> response.status
      200
      iex> response.body["message"]
      "success"
      iex> response.body["people"] |> List.first() |> Map.get("craft")
      "ISS"
  """
  def people_in_space do
    get("/astros.json")
  end

  @doc """
  Sorts the data alphabetically by last name.

  ## Examples

      iex> OpenNotify.sort_by_last_name([
      ...>  %{"craft" => "ISS", "name" => "Alexander Misurkin"},
      ...>  %{"craft" => "ISS", "name" => "Mark Vande Hei"}
      ...> ])
      [
        %{"craft" => "ISS", "name" => "Mark Vande Hei"},
        %{"craft" => "ISS", "name" => "Alexander Misurkin"}
      ]
  """
  def sort_by_last_name(data) do
    data
    |> Enum.map(fn person ->
      last_name =
        person["name"]
        |> String.split(" ")
        |> List.last()

      Map.put(person, :last_name, last_name)
    end)
    |> Enum.sort_by(& &1.last_name)
    |> Enum.map(&Map.delete(&1, :last_name))
  end

  @doc """
  Prints the result on the screen.
  """
  def show_results(data) do
    data =
      data
      |> Enum.map(fn person ->
        person
        |> Enum.map(fn {k, v} -> {String.capitalize(k), v} end)
        |> Enum.into(%{})
      end)

    TableFormatter.print_table_for_columns(data, ~w[Name Craft])
  end

  def run do
    %{status: 200, body: %{"people" => people}} = people_in_space()

    people
    |> sort_by_last_name()
    |> show_results()
  end
end

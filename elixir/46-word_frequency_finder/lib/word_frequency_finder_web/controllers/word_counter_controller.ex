defmodule WordFrequencyFinderWeb.WordCounterController do
  use WordFrequencyFinderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"file" => file, "format" => "json"}) do
    frequencies = WordFrequencyFinder.run(file.path)

    json(conn, %{"frequencies" => frequencies})
  end

  def create(conn, %{"file" => %Plug.Upload{path: path, filename: filename}}) do
    frequencies = WordFrequencyFinder.run(path) |> Enum.take(10)

    conn
    |> Plug.Conn.assign(:frequencies, frequencies)
    |> render(:show, filename: filename, frequencies: frequencies)
  end

  def create(conn, _params) do
    json(conn, %{"frequencies" => conn.assigns.frequencies})
  end
end

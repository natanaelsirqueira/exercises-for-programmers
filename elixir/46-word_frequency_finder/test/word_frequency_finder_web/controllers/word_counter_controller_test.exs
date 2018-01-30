defmodule WordCounterControllerTest do
  use WordFrequencyFinderWeb.ConnCase

  test "counts the frequency of the words in the uploaded file", %{conn: conn} do
    file = %Plug.Upload{path: "test/assets/words.txt"}

    %{"frequencies" => frequencies} =
      conn
      |> post("/word-counter", %{"file" => file, "format" => "json"})
      |> json_response(:ok)

    assert frequencies == [["badger", 7], ["mushroom", 2], ["snake", 1]]
  end
end

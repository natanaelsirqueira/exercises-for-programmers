defmodule ProductSearch.Source.File do
  @moduledoc """
  Contains the read/save operations for the JSON data using a file.
  """

  defstruct [:path]

  @doc """
  Creates a file source to be used as a database.
  """
  def new(path) do
    %__MODULE__{path: path}
  end

  defimpl ProductSearch.Source do
    def read(source) do
      File.read!(source.path)
    end

    def save(source, content) do
      File.write!(source.path, content)
    end
  end
end

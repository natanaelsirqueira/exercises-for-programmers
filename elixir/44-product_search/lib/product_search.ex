defmodule ProductSearch do
  @moduledoc """
  Contains the functions for searching and adding products.
  """

  alias ProductSearch.Source

  defmodule Product do
    @moduledoc false
    @derive [Poison.Encoder]
    defstruct [:name, :price, :quantity]
  end

  @doc false
  def source_from_file(path), do: Source.File.new(path)

  @doc false
  def source_from_string(json), do: Source.Memory.new(json)

  @doc """
  Searches for a product in the source provided.

  ## Examples

      iex> source = ProductSearch.source_from_string(~S|{
      ...>   "products" : [
      ...>     {"name": "Widget", "price": 25.00, "quantity": 5}
      ...>   ]
      ...> }|)
      iex> ProductSearch.search(source, "widget")
      %ProductSearch.Product{name: "Widget", price: 25.00, quantity: 5}
      iex> ProductSearch.search(source, "iPad")
      nil

      iex> source = ProductSearch.source_from_file("test/assets/products.json")
      iex> ProductSearch.search(source, "widget")
      %ProductSearch.Product{name: "Widget", price: 25.00, quantity: 5}
      iex> ProductSearch.search(source, "iPad")
      nil
  """
  def search(source, product_name) do
    Enum.find(list(source), &(String.downcase(&1.name) == String.downcase(product_name)))
  end

  @doc """
  Adds a product to the source provided.

  ## Examples

      iex> source = ProductSearch.source_from_string(~S|{
      ...>   "products" : [
      ...>     {"name": "Widget", "price": 25.00, "quantity": 5}
      ...>   ]
      ...> }|)
      iex> ProductSearch.search(source, "iPad")
      nil
      iex> ProductSearch.add(source, %ProductSearch.Product{name: "iPad", price: 1000.0, quantity: 2})
      :ok
      iex> ProductSearch.search(source, "iPad")
      %ProductSearch.Product{name: "iPad", price: 1000.00, quantity: 2}
  """
  def add(source, product) do
    content = encode([product | list(source)])

    save(source, content)
  end

  @doc """
  List all the products in the source provided.

  ## Examples

      iex> source = ProductSearch.source_from_file("test/assets/products.json")
      %ProductSearch.Source.File{path: "test/assets/products.json"}
      iex> ProductSearch.list(source)
      [%ProductSearch.Product{name: "Widget", price: 25.0, quantity: 5},
       %ProductSearch.Product{name: "Thing", price: 15.0, quantity: 5},
       %ProductSearch.Product{name: "Doodad", price: 5.0, quantity: 10}]
  """
  def list(source) do
    %{"products" => products} = read(source) |> parse()

    products
  end

  defp read(source), do: Source.read(source)

  defp save(source, content), do: Source.save(source, content)

  defp parse(json), do: Poison.decode!(json, as: %{"products" => [%Product{}]})

  defp encode(products), do: Poison.encode!(%{"products" => products}, pretty: true)
end

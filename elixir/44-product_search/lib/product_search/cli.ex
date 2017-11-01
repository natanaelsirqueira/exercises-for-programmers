defmodule ProductSearch.CLI do
  @moduledoc false

  # Module that is used for the escript.

  import Input

  alias ProductSearch.Product

  @empty_json ~S|{"products": []}|

  def main(argv) do
    run(OptionParser.parse(argv, switches: [in_memory: :boolean]))
  end

  def run({[in_memory: true], _, _}) do
    @empty_json
    |> ProductSearch.source_from_string()
    |> loop()
  end

  def run({_, [file_path], _}) do
    unless File.exists?(file_path) do
      File.write!(file_path, @empty_json)
    end

    file_path
    |> ProductSearch.source_from_file()
    |> loop()
  end

  def run(_), do: help()

  def loop(source) do
    product_name = string("What is the product name? ")

    case ProductSearch.search(source, product_name) do
      nil     -> not_found(source, product_name)
      product -> print(product)
    end

    loop(source)
  end

  def not_found(source, product_name) do
    IO.puts("Sorry, that product was not found in our inventory.")

    case string("Do you want to add it? [Yn] ", one_of: ~w[Y y N n]) |> String.upcase() do
      "Y" -> new(source, product_name)
      "N" -> true
    end
  end

  def new(source, product_name) do
    price = float("What is the price of the product? ", positive: true)
    quantity = integer("What is the quantity you have? ", positive: true)

    ProductSearch.add(source, %Product{name: product_name, price: price, quantity: quantity})

    IO.puts("The product was added to the inventory.")
  end

  def print(product) do
    IO.puts("""
    Name: #{product.name}
    Price: $#{format(product.price)}
    Quantity on hand: #{product.quantity}
    """)
  end

  defp format(number), do: :io_lib.format('~.2f', [number]) |> to_string()

  defp help do
    IO.puts("""
    USAGE: product_search (DB_FILE | --in-memory)
      Examples:
        1) product_search db.json
        2) product_search --in-memory

    If DB_FILE does not exist, it will be created.
    If --in-memory flag is provided, the app will use an in-memory storage.
    """)
  end
end

Code.load_file("../util/input.ex")

defmodule SelfCheckout do
  import Input

  def run do
    items = new_item(1)

    subtotal = calc_subtotal(items)
    tax = subtotal * 5.5 / 100
    total = subtotal + tax

    IO.puts "\nSubtotal: $#{subtotal}" <>
            "\nTax: $#{tax}" <>
            "\nTotal: $#{total}"
  end

  def new_item(n) do
    price = float("Enter the price of item #{n}: ")
    quantity = int_p("Enter the quantity of item #{n}: ")
    item = %{price: price, quantity: quantity}

    op = string("Do you want to add another item? [Y/N] ")
    if (op == "N") do
      [item]
    else
      [item | new_item(n + 1)]
    end
  end

  def calc_subtotal([]), do: 0.0
  def calc_subtotal([item | tail]) do
    (item.price * item.quantity) + calc_subtotal(tail)
  end
end

SelfCheckout.run()

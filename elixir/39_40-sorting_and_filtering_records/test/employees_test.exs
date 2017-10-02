defmodule EmployeesTest do
  use ExUnit.Case
  doctest Employees

  test "greets the world" do
    assert Employees.hello() == :world
  end
end

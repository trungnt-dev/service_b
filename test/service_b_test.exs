defmodule ServiceBTest do
  use ExUnit.Case
  doctest ServiceB

  test "greets the world" do
    assert ServiceB.hello() == :world
  end
end

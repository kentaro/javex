defmodule JavexTest do
  use ExUnit.Case
  doctest Javex

  test "greets the world" do
    assert Javex.hello() == :world
  end
end

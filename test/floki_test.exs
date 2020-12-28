defmodule FlokiTest do
  use ExUnit.Case
  doctest Floki

  test "greets the world" do
    assert Floki.hello() == :world
  end
end

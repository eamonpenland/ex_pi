defmodule ExPiTest do
  use ExUnit.Case
  doctest ExPi

  test "greets the world" do
    assert ExPi.hello() == :world
  end
end

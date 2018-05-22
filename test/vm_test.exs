defmodule VmTest do
  use ExUnit.Case
  doctest Vm

  test "greets the world" do
    assert Vm.hello() == :world
  end
end

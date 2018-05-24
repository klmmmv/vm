defmodule VmStarterTest do
  use ExUnit.Case

  setup do
    proc = %{name: TestProcess, subjects: [:testSubject1, :testSubject2, :testSubject3]}

    on_exit fn ->
      DynamicSupervisor.which_children(Vm.DynStarter)
      |> Enum.each(fn {_, pid, _, _} -> 
        DynamicSupervisor.terminate_child(Vm.DynStarter, pid) end)
    end

    %{proc: proc}
  end

  test "if dynstarter exists with zero s-bpm processes" do
    assert DynamicSupervisor.which_children(Vm.DynStarter) == []
  end
    
  test "starts another process", %{proc: proc} do
    Vm.DynStarter.start_process proc
    assert length(DynamicSupervisor.which_children(Vm.DynStarter)) == 1
    subjects = DynamicSupervisor.which_children TestProcess
    assert length(subjects) == 3 
  end
end

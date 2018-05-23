defmodule Vm.Process do
  use DynamicSupervisor

  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(_args, opts) do
    DynamicSupervisor.start_link(__MODULE__, :ok, opts)
  end

  def start_subjects(pid, subjects) do
    children = Enum.map(subjects, fn name ->
      %{
        id: Vm.Subject,
        start: {Vm.Subject, :start_link, [name]}
      }
    end)
    IO.puts inspect(children)
    Enum.each(children, fn child -> DynamicSupervisor.start_child(pid, child) end)
  end
end

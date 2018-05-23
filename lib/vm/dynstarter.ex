defmodule Vm.DynStarter do
  use DynamicSupervisor

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(args, opts) do
    DynamicSupervisor.start_link(__MODULE__, args, opts)
  end

  @doc """
  Awaits a process defined as

    iex> process = ${name: "Name", subjects: [:proc1, :proc2]}

  """
  def start_process(process) do
    
    {:ok, process_pid} = Vm.Process.start_link([], [name: process[:name]])
    Vm.Process.start_subjects(process_pid, process[:subjects])
  end
end

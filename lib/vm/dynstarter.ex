defmodule Vm.DynStarter do
  use DynamicSupervisor

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(opts) do
    DynamicSupervisor.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Awaits a S-BPM process defined as

    iex> process = ${name: "Name", subjects: [:proc1, :proc2]}

  Note: the id of a DynamicSupervisor is always :undefined.
  """
  def start_process(process) do
    # Specify the S-BPM process instance
    proc = %{
      id: Vm.Process,
      start: {Vm.Process, :start_link, [[], [name: process[:name]]]}
    }
    
    {:ok, process_pid} = DynamicSupervisor.start_child(Vm.DynStarter, proc)
    Vm.Process.start_subjects(process_pid, process[:subjects])
  end
end

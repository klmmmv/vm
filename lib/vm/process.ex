defmodule Vm.Process do
  use DynamicSupervisor
  require Logger

  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(_args, opts) do
    DynamicSupervisor.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Starts all the subjects of one S-BPM process instance.

  ## Examples

  #iex> {:ok, sbpm_process_pid} = DynamicSupervisor.start_child(Vm.DynStarter, %{id: Vm.Process, start: {Vm.Process, :start_link, [[],[name: DcoTestProc]]}})
  #  iex> Vm.Process.start_subjects(sbpm_process_pid, [:subj1, :subj2])
    :ok

  """ 
  def start_subjects(pid, subjects) do
    children = Enum.map(subjects, fn name ->
      %{
        id: Vm.Subject,
        start: {Vm.Subject, :start_link, [name]}
      }
    end)
    Enum.each(children, fn child -> DynamicSupervisor.start_child(pid, child) end)
  end
end

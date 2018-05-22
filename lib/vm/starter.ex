defmodule Vm.Starter do
  use GenServer

  @impl true
  def init(init_state) do
    {:ok, init_state}
  end

  def start_link(args, opts) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  ################
  ## Client API ##
  ################

  @doc """
  Instantiate a S-BPM process from an Web Ontology Language (OWL) file.
  """
  def init_proc(pid, proc) do
    GenServer.call(pid, {:init, proc}) 
  end

  def ls_proc(pid) do
    GenServer.call(pid, :ls)
  end
  
  ######################
  ## Server Callbacks ##
  ######################

  @impl true
  def handle_call({:init, proc}, _from, active_procs) do
    {:reply, [ proc | active_procs],[ proc | active_procs ]}
  end

  @impl true
  def handle_call(:ls, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast(:no, state) do
    {:noreply, state}
  end
end

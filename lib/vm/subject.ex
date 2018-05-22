defmodule Vm.Subject do
  use Agent

  def start_link(name) do
    Agent.start_link(fn -> %{} end, name: name)
  end

  def get_current_node(subj) do
    :ok
  end

  def get_state(subj) do
    Agent.get(subj, & &1)
  end
end

defmodule Vm.ASM do
  use GenStateMachine
  require Logger

  def handle_event(:cast, :flip, %{state: "state1"}, data) do
    {:next_state, %{:state => "state2"}, data}
  end

  def handle_event(:cast, :flip, %{state: "state2"}, data) do
    {:next_state, %{:state => "state1"}, data}
  end

  def handle_event({:call, from}, :get_count, state, data) do
    Logger.debug "State: " <> inspect(state)
    {:next_state, state, data, [{:reply, from, data}]}
  end
end

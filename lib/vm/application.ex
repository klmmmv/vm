defmodule Vm.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      %{
        id: SBPMSupervisor,
        start: {Vm.Starter, :start_link , [[:proc_default], [name: Muschi]]}
      },
      {
        DynamicSupervisor, name: Vm.DynStarter, strategy: :one_for_one
      }
    ]

    opts = [strategy: :one_for_one, name: Vm.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

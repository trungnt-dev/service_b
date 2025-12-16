defmodule ServiceB.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = []
    children = [
      {Cluster.Supervisor, [topologies, [name: ServiceB.ClusterSupervisor]]}
      # Starts a worker by calling: ServiceB.Worker.start_link(arg)
      # {ServiceB.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ServiceB.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

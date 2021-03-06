defmodule Personal do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Personal.Endpoint, [])
    ]

    opts = [strategy: :one_for_one, name: Personal.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Personal.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule ManagerWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ManagerWeb.Telemetry,
      # Start the Endpoint (http/https)
      ManagerWeb.Endpoint
      # Start a worker by calling: ManagerWeb.Worker.start_link(arg)
      # {ManagerWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ManagerWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

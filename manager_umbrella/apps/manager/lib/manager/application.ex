defmodule Manager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Manager.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Manager.PubSub}
      # Start a worker by calling: Manager.Worker.start_link(arg)
      # {Manager.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Manager.Supervisor)
  end
end

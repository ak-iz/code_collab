defmodule CodeCollab.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      CodeCollabWeb.Telemetry,
      # Start the Ecto repository
      CodeCollab.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: CodeCollab.PubSub},
      # Start Finch
      {Finch, name: CodeCollab.Finch},
      # Start the Endpoint (http/https)
      CodeCollabWeb.Endpoint
      # Start a worker by calling: CodeCollab.Worker.start_link(arg)
      # {CodeCollab.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CodeCollab.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CodeCollabWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

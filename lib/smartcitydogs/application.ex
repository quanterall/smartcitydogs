defmodule Smartcitydogs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Smartcitydogs.Repo,
      # Start the endpoint when the application starts
      SmartcitydogsWeb.Endpoint,
      # Starts a worker by calling: Smartcitydogs.Worker.start_link(arg)
      # {Smartcitydogs.Worker, arg},
      {Task.Supervisor, name: Smartcitydogs.TaskSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Smartcitydogs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SmartcitydogsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

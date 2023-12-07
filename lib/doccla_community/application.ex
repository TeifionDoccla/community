defmodule DocclaCommunity.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Migrations
      {Ecto.Migrator,
         repos: Application.fetch_env!(:doccla_community, :ecto_repos),
         skip: System.get_env("SKIP_MIGRATIONS") == "true"},

      DocclaCommunityWeb.Telemetry,
      DocclaCommunity.Repo,
      {DNSCluster, query: Application.get_env(:doccla_community, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DocclaCommunity.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DocclaCommunity.Finch},
      # Start a worker by calling: DocclaCommunity.Worker.start_link(arg)
      # {DocclaCommunity.Worker, arg},
      # Start to serve requests, typically the last entry
      DocclaCommunityWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DocclaCommunity.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DocclaCommunityWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

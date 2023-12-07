defmodule DocclaCommunity.Repo do
  use Ecto.Repo,
    otp_app: :doccla_community,
    adapter: Ecto.Adapters.Postgres
end

defmodule DocclaCommunity.Events.Webinar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "webinars" do
    belongs_to :host, DocclaCommunity.Accounts.User
    field :description, :string
    field :title, :string
    field :image, :string
    field :url, :string
    field :start_time, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(webinar, attrs) do
    webinar
    |> cast(attrs, ~w(host_id title description image url start_time)a)
    |> validate_required(~w(host_id title url start_time)a)
  end
end

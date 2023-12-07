defmodule DocclaCommunity.Repo.Migrations.CreateWebinars do
  use Ecto.Migration

  def change do
    create table(:webinars) do
      add :host_id, references(:users, on_delete: :nothing)
      add :title, :string
      add :description, :text
      add :image, :string
      add :url, :string
      add :start_time, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end

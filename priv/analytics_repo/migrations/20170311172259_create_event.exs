defmodule DPW.AnalyticsRepo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :method, :text
      add :path, :text
      add :query, :text
      add :user_agent, :text
      add :ip, :text
      add :meta, :map

      timestamps()
    end

  end
end

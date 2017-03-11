defmodule DPW.AnalyticsRepo.Migrations.AddIdentifierToAnalytics do
  use Ecto.Migration

  def change do
    alter table(:events) do
      add :identifier, :text
    end
  end
end

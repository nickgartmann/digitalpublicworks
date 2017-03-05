defmodule DPW.Repo.Migrations.CreateResponse do
  use Ecto.Migration

  def change do
    create table(:responses) do
      add :form_key, :text
      add :answers, :map

      timestamps()
    end

  end
end

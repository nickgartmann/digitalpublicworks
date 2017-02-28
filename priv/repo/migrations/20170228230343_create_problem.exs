defmodule DPW.Repo.Migrations.CreateProblem do
  use Ecto.Migration

  def change do
    create table(:problems) do
      add :title, :text
      add :description, :text
      add :needs, :text
      add :featured, :boolean, default: false, null: false

      timestamps()
    end

  end
end

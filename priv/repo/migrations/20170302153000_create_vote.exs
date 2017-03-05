defmodule DPW.Repo.Migrations.CreateVote do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :direction, :boolean, default: false, null: false
      add :fingerprint, :text
      add :problem_id, references(:problems, on_delete: :nothing)

      timestamps()
    end
    create index(:votes, [:problem_id])

  end
end

defmodule DPW.Repo.Migrations.AddUserToVote do
  use Ecto.Migration

  def change do
    alter table(:votes) do
      add :user_id, references(:users, on_delete: :nothing)
    end
  end
end

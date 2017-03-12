defmodule DPW.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email_address, :text
      add :encrypted_password, :text
      add :password_reset_token, :text
      add :roles, {:array, :text}

      timestamps()
    end

  end
end

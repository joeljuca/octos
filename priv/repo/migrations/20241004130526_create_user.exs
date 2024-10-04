defmodule Octos.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      timestamps(type: :utc_datetime)

      add :name, :string, null: false
      add :email, :string, null: false
    end
  end
end

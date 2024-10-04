defmodule Octos.Repo.Migrations.CreateCamera do
  use Ecto.Migration

  def change do
    create table(:camera) do
      timestamps(type: :utc_datetime)

      add :user_id, references(:user, on_delete: :delete_all), null: false
      add :brand, :string, null: false
      add :model, :string, null: false
      add :status, :boolean, null: false, default: true
    end

    create index(:camera, [:user_id, :status])
  end
end

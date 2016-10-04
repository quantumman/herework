defmodule Herework.Repo.Migrations.AssociateUserAndMessage do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :creator_id, references(:users, on_delete: :nothing)
    end
  end
end

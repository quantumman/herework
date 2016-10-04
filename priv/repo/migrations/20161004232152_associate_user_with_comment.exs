defmodule Herework.Repo.Migrations.AssociateUserWithComment do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :creator_id, references(:users, on_delete: :nothing)
    end
  end
end

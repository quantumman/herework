defmodule Herework.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :avatar, :string
      add :name, :string
      add :email, :string

      timestamps()
    end

  end
end

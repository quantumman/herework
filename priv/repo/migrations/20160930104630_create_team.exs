defmodule Herework.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :domain, :string

      timestamps()
    end

  end
end

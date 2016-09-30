defmodule Herework.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :title, :string

      timestamps()
    end

  end
end

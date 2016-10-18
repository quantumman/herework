defmodule Herework.Repo.Migrations.AddBodyToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :body, :string, size: 1000
    end
  end
end

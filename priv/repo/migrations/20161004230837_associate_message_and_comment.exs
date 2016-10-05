defmodule Herework.Repo.Migrations.AssociateMessageAndComment do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :message_id, references(:messages)
    end
  end
end

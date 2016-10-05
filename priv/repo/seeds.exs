# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Herework.Repo.insert!(%Herework.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Forge

generate = fn _ ->
  {:ok, creator} = Forge.saved_user
  {:ok, message} = Ecto.build_assoc(creator, :messages, Forge.message)
  |> Herework.Repo.insert

  creators = Forge.saved_user_list(10) |> Enum.map(&elem(&1, 1))
  comments = creators
  |> Enum.map(&Ecto.build_assoc(&1, :comments, Forge.comment))
  |> Enum.map(&Ecto.build_assoc(message, :comments, &1))
  |> Enum.each(&Herework.Repo.insert(&1)) # FIXME Insert insdie transaction
end

1..10
|> Enum.each(generate)

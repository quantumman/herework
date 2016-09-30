defmodule Herework.Team do
  use Herework.Web, :model

  schema "teams" do
    field :domain, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:domain])
    |> validate_required([:domain])
  end
end

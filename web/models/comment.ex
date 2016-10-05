defmodule Herework.Comment do
  use Herework.Web, :model

  schema "comments" do
    field :body, :string

    belongs_to :creator, Herework.User, foreign_key: :creator_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end
end

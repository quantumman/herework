defmodule Herework.Message do
  use Herework.Web, :model

  schema "messages" do
    field :title, :string

    has_many :comments, Herework.Comment

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end

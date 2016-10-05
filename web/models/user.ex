defmodule Herework.User do
  use Herework.Web, :model

  schema "users" do
    field :avatar, :string
    field :name, :string
    field :email, :string

    has_many :messages, Herework.Message, foreign_key: :creator_id
    has_many :comments, Herework.Comment, foreign_key: :creator_id
    belongs_to :team, Herework.Team

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:avatar, :name, :email])
    |> validate_required([:avatar, :name, :email])
  end
end

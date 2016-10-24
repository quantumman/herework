defmodule Herework.User do
  use Herework.Web, :model

  @derive {Poison.Encoder, except: [:__meta__, :messages, :comments, :team]}

  schema "users" do
    field :avatar, :string
    field :name, :string
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true

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
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
  end
end

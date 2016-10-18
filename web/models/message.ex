defmodule Herework.Message do
  use Herework.Web, :model

  schema "messages" do
    field :title, :string
    field :body, :string

    has_many :comments, Herework.Comment
    belongs_to :creator, Herework.User, foreign_key: :creator_id, references: :id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :body])
    |> validate_length(:body, max: 1000)
    |> validate_required([:title, :body])
  end
end

defmodule Herework.Comment do
  use Herework.Web, :model

  @derive {Poison.Encoder, except: [:__meta__]}

  schema "comments" do
    field :body, :string

    belongs_to :message, Herework.Message
    belongs_to :creator, Herework.User, foreign_key: :creator_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body, :message_id])
  end
end

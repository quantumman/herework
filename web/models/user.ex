defmodule Herework.User do
  use Herework.Web, :model

  alias Herework.Repo

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
    |> unique_constraint(:email, name: :users_email_index)
    |> validate_format(:email, ~r/@/)
    |> validate_required([:email, :password])
  end

  def find_and_confirm_password(params = %{"email" => email, "password" => password}) do
    changeset = changeset(%Herework.User{}, params)
    user = Repo.one(
      from u in Herework.User,
      where: u.email == ^email
    )

    if user do
      valid = password
      |> Comeonin.Bcrypt.checkpw(user.hashed_password)
      if valid do
        {:ok, user}
      else
        {:error, changeset}
      end
    else
      {:error, changeset}
    end
  end

  def generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        Ecto.Changeset.put_change(current_changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset
    end
  end
end

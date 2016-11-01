defmodule Herework.JoinController  do
  use Herework.Web, :controller

  alias Herework.{Repo, User}

  plug :scrub_params, "user" when action in [:create]

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "index.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :token)

        conn
        |> redirect(to: page_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("index.html", changeset: changeset)
    end
  end

  defp changeset(model, params \\ :invalid) do
    model
    |> User.changeset(params)
    |> User.generate_encrypted_password
  end
end

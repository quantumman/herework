defmodule Herework.SessionController do
  use Herework.Web, :controller
  use Guardian.Phoenix.Controller

  alias Herework.{Repo, User}

  def index(conn, _param, _user, _claims) do
    changeset = User.changeset(%User{})
    render conn, "index.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}, _user, _claims) do
    case User.find_and_confirm_password(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Logged in.")
        |> Guardian.Plug.sign_in(user) # verify your logged in resource
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("index.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(Herework.ErrorView, "401.json", message: "Authentication required")
  end
end

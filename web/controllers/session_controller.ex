defmodule Herework.SessionController do
  use Herework.Web, :controller
  use Guardian.Phoenix.Controller

  def create(conn, _params, user, _claims) do
    conn
    |> put_flash(:info, "Logged in.")
    |> Guardian.Plug.sign_in(user) # verify your logged in resource
    |> redirect(to: user_path(conn, :index))
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

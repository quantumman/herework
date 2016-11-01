defmodule Herework.UserController do
  use Herework.Web, :controller
  use Guardian.Phoenix.Controller

  alias Herework.User

  plug Guardian.Plug.EnsureAuthenticated, handler: Herework.SessionContr
  def index(conn, _params, _user, _claims) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}, _user, _claims) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def delete(conn, %{"id" => id}, _user, _claims) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end
end

defmodule Herework.PageController do
  use Herework.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Herework.SessionController

  def index(conn, _params) do
    render conn, "index.html"
  end
end

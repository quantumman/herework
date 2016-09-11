defmodule Herework.PageController do
  use Herework.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

defmodule Herework.AppController do
  use Herework.Web, :controller

  def index(conn, _params) do
    base = Herework.Router.Helpers.url(conn)
    app = %{
      messages_url: base <> message_path(conn, :index),
      tasks_url: base <> "/api/tasks",
      activity_url: base <> "/api/activity"
    }
    render(conn, "index.json", app: app)
  end
end

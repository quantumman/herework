defmodule Herework.AppControllerTest do
  use Herework.ConnCase

  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all resources", %{conn: conn} do
    conn = get conn, app_path(conn, :index)
    base = Herework.Router.Helpers.url(conn)
    assert json_response(conn, 200) ==
      %{
        "messages_url" => base <> "/api/messages",
        "tasks_url" => base <> "/api/tasks",
        "activity_url" => base <> "/api/activity"
      }
  end
end

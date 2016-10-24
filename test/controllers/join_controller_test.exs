defmodule Herework.JoinControllerTest do
  use Herework.ConnCase
  require Forge

  alias Herework.User
  @valid_attrs %{email: "test user", password: "rawpassword"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok,
     conn: put_req_header(conn, "accept", "text/html"),
    }
  end

  test "signs up on create", %{conn: conn} do
    conn = post conn, join_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["jwt"]
    assert json_response(conn, 201)["user"]
  end

  test "does not sign up on create", %{conn: conn} do
    conn = post conn, join_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)
  end
end

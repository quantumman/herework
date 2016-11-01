defmodule Herework.JoinControllerTest do
  use Herework.ConnCase
  require Forge

  @valid_attrs %{email: "valid@email.com", password: "rawpassword"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok,
     conn: put_req_header(conn, "accept", "text/html"),
    }
  end

  test "signs up on create", %{conn: conn} do
    conn = post conn, join_path(conn, :create), user: @valid_attrs
    assert html_response(conn, 302) =~ "redirected"
  end

  test "does not sign up on create", %{conn: conn} do
    conn = post conn, join_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 422) =~ "Sign Up"
  end
end

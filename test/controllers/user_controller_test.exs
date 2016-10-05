defmodule Herework.UserControllerTest do
  use Herework.ConnCase
  require Forge
  require TestHelper

  alias Herework.User
  @valid_attrs %{avatar: "some content", email: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, user} = Forge.saved_user

    {:ok,
     conn: put_req_header(conn, "accept", "application/json"),
     user: user
    }
  end

  test "lists all entries on index", %{conn: conn, user: user} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200)["data"] == [
      %{"id" => user.id,
        "avatar" => user.avatar,
        "name" => user.name,
        "email" => user.email,
        "created_at" => TestHelper.formatted_time(user.inserted_at)
       }
    ]
  end

  test "shows chosen resource", %{conn: conn, user: user} do
    conn = get conn, user_path(conn, :show, user)
    assert json_response(conn, 200)["data"] ==
      %{"id" => user.id,
        "avatar" => user.avatar,
        "name" => user.name,
        "email" => user.email,
        "created_at" => TestHelper.formatted_time(user.inserted_at)
       }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end
end

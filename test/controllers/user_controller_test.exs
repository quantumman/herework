defmodule Herework.UserControllerTest do
  use Herework.ConnCase
  require Forge
  require TestHelper

  alias Herework.User
  @valid_attrs %{avatar: "some content", email: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, user} = Forge.saved_user

    conn = conn
    |> put_req_header("accept", "application/json")
    |> Guardian.Plug.api_sign_in(user)

    {:ok,
     conn: conn,
     user: user
    }
  end

  test "lists all entries on index", %{conn: conn, user: user} do
    conn = get conn, user_path(conn, :index)
    assert json_response(conn, 200) == [
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
    assert json_response(conn, 200) ==
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

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = delete conn, user_path(conn, :delete, user)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end
end

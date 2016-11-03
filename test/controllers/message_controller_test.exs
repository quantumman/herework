defmodule Herework.MessageControllerTest do
  use Herework.ConnCase
  require Forge

  alias Herework.Message
  @valid_attrs %{title: "some content", body: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, creator} = Forge.saved_user
    {:ok, message} =
      Ecto.build_assoc(creator, :messages, Forge.message)
      |> Repo.insert

    conn = conn
    |> put_req_header("accept", "application/json")
    |> Guardian.Plug.api_sign_in(creator)

    {:ok,
     conn: conn,
     message: message,
     loggedInUser: creator
    }
  end

  test "lists all entries on index", %{conn: conn, message: message} do
    conn = get conn, message_path(conn, :index)
    message = Message
    |> Repo.get_by(id: message.id)
    |> Repo.preload(:creator)
    assert json_response(conn, 200) == [
      %{"id" => message.id,
        "title" => message.title,
        "body" => message.body,
        "url" => "/api/messages",
        "comments_url" => "/api/messages/#{message.id}/comments",
        "created_at" => TestHelper.formatted_time(message.creator.inserted_at),
        "creator" => %{
          "id" => message.creator.id,
          "name" => message.creator.name,
          "email" => message.creator.email,
          "avatar" => message.creator.avatar,
          "created_at" => TestHelper.formatted_time(message.creator.inserted_at)
        }
       }
    ]
  end

  test "shows chosen resource", %{conn: conn, message: message} do
    conn = get conn, message_path(conn, :show, message)
    message = Message
    |> Repo.get_by(id: message.id)
    |> Repo.preload(:creator)
    assert json_response(conn, 200) ==
      %{"id" => message.id,
        "title" => message.title,
        "url" => "/api/messages",
        "body" => message.body,
        "comments_url" => "/api/messages/#{message.id}/comments",
        "created_at" => TestHelper.formatted_time(message.creator.inserted_at),
        "creator" => %{
          "id" => message.creator.id,
          "name" => message.creator.name,
          "email" => message.creator.email,
          "avatar" => message.creator.avatar,
          "created_at" => TestHelper.formatted_time(message.creator.inserted_at)
        }
       }
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, message_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn, loggedInUser: user} do
    conn = post conn, message_path(conn, :create), message: @valid_attrs
    assert json_response(conn, 201)["id"]

    resource =
      Repo.get_by(Message, @valid_attrs)
      |> Repo.preload(:creator)
    assert resource
    assert resource.creator == user
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, message_path(conn, :create), message: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn, message: message, loggedInUser: user} do
    conn = put conn, message_path(conn, :update, message), message: @valid_attrs
    assert json_response(conn, 200)["id"]

    resource =
      Repo.get_by(Message, @valid_attrs)
      |> Repo.preload(:creator)
    assert resource
    assert resource.creator == user
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    message = Repo.insert! %Message{}
    conn = put conn, message_path(conn, :update, message), message: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    message = Repo.insert! %Message{}
    conn = delete conn, message_path(conn, :delete, message)
    assert response(conn, 204)
    refute Repo.get(Message, message.id)
  end
end

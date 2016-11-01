defmodule Herework.CommentControllerTest do
  use Herework.ConnCase
  require Forge
  require TestHelper

  alias Herework.Comment
  @valid_attrs %{body: "some content"}
  @invalid_attrs %{}

  defp build_models() do
    {:ok, message} = Forge.saved_message
    {:ok, creator} = Forge.saved_user
    {:ok, comment} =
      Ecto.build_assoc(creator, :comments, Forge.comment)
      |> (&Ecto.build_assoc(message, :comments, &1)).()
      |> Herework.Repo.insert
    { message, comment, creator }
  end

  setup %{conn: conn} do
    build_models
    { message, comment, creator } = build_models

    conn = conn
    |> put_req_header("accept", "application/json")
    |> Guardian.Plug.api_sign_in(creator)

    {:ok,
     conn: conn,
     comment: comment,
     message: message
    }
  end

  test "lists all entries on index", %{conn: conn, message: message, comment: comment} do
    conn = get conn, message_comment_path(conn, :index, message.id)
    comment = Comment
      |> Herework.Repo.get_by(id: comment.id)
      |> Herework.Repo.preload(:creator)
    assert json_response(conn, 200) == [
      %{"id" => comment.id,
        "message_id" => comment.message_id,
        "body" => comment.body,
        "creator" => %{
          "id" => comment.creator.id,
          "name" => comment.creator.name,
          "email" => comment.creator.email,
          "avatar" => comment.creator.avatar,
          "created_at" => TestHelper.formatted_time(comment.creator.inserted_at)
        }
       }
    ]
  end

  test "shows chosen resource", %{conn: conn, comment: comment} do
    conn = get conn, message_comment_path(conn, :show, comment.message_id, comment)
    comment = Comment
      |> Herework.Repo.get_by(id: comment.id)
      |> Herework.Repo.preload(:creator)
    assert json_response(conn, 200) ==
      %{"id" => comment.id,
        "message_id" => comment.message_id,
        "body" => comment.body,
        "creator" => %{
          "id" => comment.creator.id,
          "name" => comment.creator.name,
          "email" => comment.creator.email,
          "avatar" => comment.creator.avatar,
          "created_at" => TestHelper.formatted_time(comment.creator.inserted_at)
        }
       }
  end

  test "creates and renders resource when data is valid", %{conn: conn, message: message} do
    conn = post conn, message_comment_path(conn, :create, message.id), comment: @valid_attrs
    assert json_response(conn, 201)["id"]
    assert json_response(conn, 201)["message_id"] == message.id
    assert Repo.get_by(Comment, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, message: message} do
    conn = post conn, message_comment_path(conn, :create, message.id), comment: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn, message: message, comment: comment} do
    conn = put conn, message_comment_path(conn, :update, message.id, comment), comment: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Comment, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, message: message} do
    comment =
      message
      |> Ecto.build_assoc(:comments, %Comment{})
      |> Repo.insert!
    conn = put conn, message_comment_path(conn, :update, message.id, comment), comment: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn, message: message} do
    comment =
      message
      |> Ecto.build_assoc(:comments, %Comment{})
      |> Repo.insert!
    conn = delete conn, message_comment_path(conn, :delete, message.id, comment)
    assert response(conn, 204)
    refute Repo.get(Comment, comment.id)
  end

  test "renders page not found  when message_id and id are nonexistent", %{conn: conn} do
    TestHelper.assert_error_sent [:show, :update, :delete], 404, fn action ->
      get conn, message_comment_path(conn, action, -1, -1)
      json_response(conn, 404)["errors"]["message"] == "Not Found"
    end
  end

  test "renders page not found when id are nonexistent", %{conn: conn, comment: comment} do
    TestHelper.assert_error_sent [:show, :update, :delete], 404, fn action ->
      get conn, message_comment_path(conn, action, comment.message_id, -1)
      json_response(conn, 404)["errors"]["message"] == "Not Found"
    end
  end

  test "renders page not found when message_id are nonexistent", %{conn: conn, comment: comment} do
    TestHelper.assert_error_sent [:show, :update, :delete], 404, fn action ->
      get conn, message_comment_path(conn, action, -1, comment)
      json_response(conn, 404)["errors"]["message"] == "Not Found"
    end

    TestHelper.assert_error_sent [:index, :create], 404, fn action ->
      get conn, message_comment_path(conn, action, -1)
      json_response(conn, 404)["errors"]["message"] == "Not Found"
    end
  end
end

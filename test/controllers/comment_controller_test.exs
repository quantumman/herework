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
    { message, comment }
  end

  setup %{conn: conn} do
    build_models
    { message, comment } = build_models

    {:ok,
     conn: put_req_header(conn, "accept", "application/json"),
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

  test "renders page not found when message_id and id are nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, message_comment_path(conn, :show, -1, -1)
    end
  end

  test "renders page not found when id is nonexistent", %{conn: conn, comment: comment} do
    assert_error_sent 404, fn ->
      get conn, message_comment_path(conn, :show, comment.message_id, -1)
    end
  end

  test "renders page not found when message_id are nonexistent", %{conn: conn, comment: comment } do
    assert_error_sent 404, fn ->
      get conn, message_comment_path(conn, :show, 1, comment)
    end
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
end

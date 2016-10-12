defmodule Herework.CommentController do
  use Herework.Web, :controller

  alias Herework.Comment
  alias Herework.Message

  def index(conn, %{"message_id" => message_id}) do
    comments =
      Message
      |> Repo.get!(message_id)
      |> Repo.preload(:comments)
      |> (&(&1.comments)).()
      |> Repo.preload(:creator)

    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"message_id" => message_id, "comment" => comment_params}) do
    changeset =
      Message
      |> Repo.get!(message_id)
      |> Ecto.build_assoc(:comments)
      |> Comment.changeset(comment_params)

    case Repo.insert(changeset) do
      {:ok, comment} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", message_comment_path(conn, :show, comment.message_id, comment))
        |> render("create.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Herework.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "message_id" => message_id}) do
    comment = Comment
    |> Repo.get_by!(id: id, message_id: message_id)
    |> Repo.preload(:creator)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "message_id" => message_id,  "comment" => comment_params}) do
    changeset =
      Comment
      |> Repo.get_by!(id: id, message_id: message_id)
      |> Comment.changeset(comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        render(conn, "update.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Herework.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"message_id" => message_id, "id" => id}) do
    comment =
      Comment
      |> Repo.get_by!(id: id, message_id: message_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    send_resp(conn, :no_content, "")
  end
end

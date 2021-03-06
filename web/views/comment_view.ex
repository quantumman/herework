defmodule Herework.CommentView do
  use Herework.Web, :view

  def render("index.json", %{comments: comments}) do
    render_many(comments, Herework.CommentView, "comment.json")
  end

  def render("show.json", %{comment: comment}) do
    render_one(comment, Herework.CommentView, "comment.json")
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      message_id: comment.message_id,
      body: comment.body,
      creator: Herework.UserView.render("user.json", %{user: comment.creator}),
      created_at: comment.inserted_at
    }
  end

  def render("update.json", %{comment: comment}) do
    render_one(comment, Herework.CommentView, "create.json")
  end

  def render("create.json", %{comment: comment}) do
    %{id: comment.id,
      message_id: comment.message_id,
      body: comment.body,
      created_at: comment.inserted_at
    }
  end
end

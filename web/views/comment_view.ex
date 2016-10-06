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
      body: comment.body,
      creator: Herework.UserView.render("user.json", %{user: comment.creator})
    }
  end

  def render("update.json", %{comment: comment}) do
    render_one(comment, Herework.CommentView, "create.json")
  end

  def render("create.json", %{comment: comment}) do
    %{id: comment.id,
      body: comment.body
    }
  end
end

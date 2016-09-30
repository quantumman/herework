defmodule Herework.CommentView do
  use Herework.Web, :view

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, Herework.CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, Herework.CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      body: comment.body}
  end
end

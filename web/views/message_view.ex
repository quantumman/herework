defmodule Herework.MessageView do
  use Herework.Web, :view

  def render("index.json", %{messages: messages, conn: conn}) do
    messages = Enum.map(messages, &(Map.put(&1, :conn, conn)))
    render_many(messages, Herework.MessageView, "message.json")
  end

  def render("show.json", %{message: message, conn: conn}) do
    message = Map.put(message, :conn, conn)
    render_one(message, Herework.MessageView, "message.json")
  end

  def render("_show.json", %{message: message, conn: conn}) do
    message = Map.put(message, :conn, conn)
    render_one(message, Herework.MessageView, "_message.json")
  end

  def render("message.json", %{message: message}) do
    conn = message.conn
    %{id: message.id,
      title: message.title,
      url: message_path(conn, :index),
      comments_url:  message_comment_path(conn, :index, message.id),
      created_at: message.inserted_at,
      creator: Herework.UserView.render("user.json", %{user: message.creator})
    }
  end

  def render("_message.json", %{message: message}) do
    conn = message.conn
    %{id: message.id,
      title: message.title,
      url: message_path(conn, :index),
      comments_url: message_comment_path(conn, :index, message.id),
      created_at: message.inserted_at
    }
  end
end

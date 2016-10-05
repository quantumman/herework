defmodule Herework.MessageView do
  use Herework.Web, :view

  def render("index.json", %{messages: messages}) do
    render_many(messages, Herework.MessageView, "message.json")
  end

  def render("show.json", %{message: message}) do
    render_one(message, Herework.MessageView, "message.json")
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      title: message.title}
  end
end

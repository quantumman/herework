defmodule Herework.AppView do
  use Herework.Web, :view

  def render("index.json", %{app: app}) do
    %{
      messages_url: app.messages_url,
      tasks_url: app.tasks_url,
      activity_url: app.activity_url
    }
  end
end

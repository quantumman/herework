defmodule Herework.UserView do
  use Herework.Web, :view

  def render("index.json", %{users: users}) do
    render_many(users, Herework.UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, Herework.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      avatar: user.avatar,
      name: user.name,
      email: user.email,
      created_at: user.inserted_at
    }
  end
end

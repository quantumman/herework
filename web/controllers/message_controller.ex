defmodule Herework.MessageController do
  use Herework.Web, :controller
  use Guardian.Phoenix.Controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Herework.SessionController

  alias Herework.Message

  def index(conn, _params, _user, _claims) do
    messages = Repo.all(Message) |> Repo.preload(:creator)
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}, user, _claims) do
    changeset = Message.changeset_with(message_params, user)

    case Repo.insert(changeset) do
      {:ok, message} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", message_path(conn, :show, message))
        |> render("show.json", message: with_assoc(message))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Herework.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _user, _claims) do
    message = Repo.get!(Message, id) |> Repo.preload(:creator)
    render(conn, "show.json", message: message)
  end

  def update(conn, %{"id" => id, "message" => message_params}, _user, _claims) do
    message = Repo.get!(Message, id)
    changeset = Message.changeset(message, message_params)

    case Repo.update(changeset) do
      {:ok, message} ->
        render(conn, "show.json", message: with_assoc(message))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Herework.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, _user, _claims) do
    message = Repo.get!(Message, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(message)

    send_resp(conn, :no_content, "")
  end

  defp with_assoc(message) do
    message |> Repo.preload(:creator)
  end
end

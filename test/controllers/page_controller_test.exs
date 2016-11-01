defmodule Herework.PageControllerTest do
  use Herework.ConnCase
  require Forge

  setup %{conn: conn} do
    {:ok, creator} = Forge.saved_user
    conn = Guardian.Plug.api_sign_in(conn, creator)
    {:ok, conn: conn}
  end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<main role=\"main\">\n<div id=\"elm-main\"></div>"
  end
end

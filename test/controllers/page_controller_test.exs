defmodule Herework.PageControllerTest do
  use Herework.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "<main role=\"main\">\n<div id=\"elm-main\"></div>"
  end
end

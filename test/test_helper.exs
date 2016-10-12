ExUnit.start

Ecto.Adapters.SQL.Sandbox.mode(Herework.Repo, :manual)

defmodule TestHelper do
  use Herework.ConnCase
  use Timex

  def formatted_time(time) do
    Ecto.DateTime.to_erl(time)
    |> Timex.to_datetime("Etc/UTC")
    |> Timex.format!("%FT%T", :strftime)
  end

  def assert_error_sent([action | actions], status, callback) do
    assert_error_sent status, fn ->
      callback.(action)
    end
    TestHelper.assert_error_sent(actions, status, callback)
  end
  def assert_error_sent([], _status, _callback) do
  end
end

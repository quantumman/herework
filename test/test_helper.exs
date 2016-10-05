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
end

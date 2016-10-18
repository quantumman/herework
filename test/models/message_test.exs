defmodule Herework.MessageTest do
  use Herework.ModelCase

  alias Herework.Message

  @valid_attrs %{title: "some content", body: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Message.changeset(%Message{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid length body" do
    invalid_body = Stream.cycle(['a', 'b', 'c']) |> Enum.take(1001)
    changeset = Message.changeset(%Message{}, %{title: "some content", body: invalid_body})
    refute changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Message.changeset(%Message{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule Herework.UserTest do
  use Herework.ModelCase
  require Forge

  alias Herework.User

  @valid_attrs %{email: "email@example.com", password: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "find_and_confirm_password for valid user" do
    model = %{"email" => "test@example.com", "password" => "ABC"}
    {:ok, _user} =
      User.changeset(%User{}, model)
      |> User.generate_encrypted_password
      |> Repo.insert

    assert {:ok, _user} = User.find_and_confirm_password(model)
  end

  test "find_and_confirm_password with invalid password" do
    model = %{"email" => "test@example.com", "password" => "ABC"}
    {:ok, _user} =
      User.changeset(%User{}, model)
      |> User.generate_encrypted_password
      |> Repo.insert

    invalidModel = %{"email" => "test@example.com", "password" => "CBA"}
    assert {:error, _changeset} = User.find_and_confirm_password(invalidModel)
  end

  test "find_and_confirm_password with unexisted user" do
    model = %{"email" => "test@example.com", "password" => "ABC"}
    {:ok, _user} =
      User.changeset(%User{}, model)
      |> User.generate_encrypted_password
      |> Repo.insert

    unexisted = %{"email" => "test@example.co.jp", "password" => "ABC"}
    assert {:error, _changeset} = User.find_and_confirm_password(unexisted)
  end
end

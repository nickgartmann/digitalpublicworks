defmodule DPW.UserTest do
  use DPW.ModelCase

  alias DPW.User

  @valid_attrs %{email_address: "some content", encrypted_password: "some content", password_reset_token: "some content", roles: []}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

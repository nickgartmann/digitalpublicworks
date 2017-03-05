defmodule DPW.ResponseTest do
  use DPW.ModelCase

  alias DPW.Response

  @valid_attrs %{answers: %{}, form_key: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Response.changeset(%Response{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Response.changeset(%Response{}, @invalid_attrs)
    refute changeset.valid?
  end
end

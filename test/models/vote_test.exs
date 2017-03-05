defmodule DPW.VoteTest do
  use DPW.ModelCase

  alias DPW.Vote

  @valid_attrs %{direction: true, fingerprint: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Vote.changeset(%Vote{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Vote.changeset(%Vote{}, @invalid_attrs)
    refute changeset.valid?
  end
end

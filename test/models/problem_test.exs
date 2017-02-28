defmodule DPW.ProblemTest do
  use DPW.ModelCase

  alias DPW.Problem

  @valid_attrs %{description: "some content", featured: true, needs: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Problem.changeset(%Problem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Problem.changeset(%Problem{}, @invalid_attrs)
    refute changeset.valid?
  end
end

defmodule DPW.EventTest do
  use DPW.ModelCase

  alias DPW.Event

  @valid_attrs %{ip: "some content", meta: %{}, path: "some content", query: "some content", user_agent: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end

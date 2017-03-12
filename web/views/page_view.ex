defmodule DPW.PageView do
  use DPW.Web, :view

  def my_vote(conn, problem) do
    case conn.assigns[:current_user] do
      nil -> nil
      %DPW.User{id: id} -> Enum.find(problem.votes, fn(vote) ->
        vote.user_id == id
      end)
    end
  end

  def count_votes(problem, direction) do
    problem.votes
    |> Enum.filter(fn(v) -> v.direction == direction end)
    |> Enum.count()
  end

end

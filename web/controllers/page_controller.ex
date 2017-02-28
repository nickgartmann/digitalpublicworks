defmodule DPW.PageController do
  use DPW.Web, :controller

  alias DPW.{Repo, Problem}

  def index(conn, _params) do
    problems = Problem.featured() 
      |> Repo.all()

    render conn, "index.html", problems: problems
  end

  def problem(conn, %{"id" => problem_id}) do
    case Repo.get(Problem, problem_id) do 
      nil     -> redirect(conn, to: "/")
      problem -> render(conn, "problem.html", problem: problem)
    end
  end
end

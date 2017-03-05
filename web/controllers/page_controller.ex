defmodule DPW.PageController do
  use DPW.Web, :controller

  alias DPW.{Repo, Problem}

  def index(conn, _params) do
    problems = Problem.featured() 
      |> Repo.all()
    render conn, "index.html", problems: problems
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
  
  def privacy(conn, _params) do
    render conn, "privacy.html"
  end

  def contact(conn, _params) do
    render conn, "contact.html"
  end
  
  def terms(conn, _params) do
    render conn, "terms.html"
  end

  def submit(conn, _params) do
    render conn, "submit.html"
  end

  def login(conn, _params) do
    render conn, "login.html"
  end

  def problem(conn, %{"id" => problem_id}) do
    case Repo.get(Problem, problem_id) do 
      nil     -> redirect(conn, to: "/")
      problem -> render(conn, "problem.html", problem: problem)
    end
  end

  def cast_vote(conn, %{"id" => problem_id, "direction" => "yes"}) do
    case Repo.get(Problem, problem_id) do 
      nil     -> redirect(conn, to: "/")
      problem -> 
        conn
        |> vote(problem, true)
        |> render("problem.html", problem: problem)
    end
  end

  def cast_vote(conn, %{"id" => problem_id, "direction" => "no"}) do
    case Repo.get(Problem, problem_id) do 
      nil     -> redirect(conn, to: "/")
      problem -> 
        conn
        |> vote(problem, false)
        |> render("problem.html", problem: problem)
    end
  end

  defp vote(conn, _problem, _direction) do
    # TODO: create a fingerprint for the vote if user is not logged in
    # TODO: set a cookie that they have already voted, and which direction they voted
    # TODO: create a new vote
    conn
  end

end

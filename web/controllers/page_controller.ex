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
end
